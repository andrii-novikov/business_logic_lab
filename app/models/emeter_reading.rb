class EmeterReading < ApplicationRecord
  validates :date, presence: true

  validates :zone_1,
            presence: true,
            numericality: {
              greater_than_or_equal_to: ->(_) { order(created_at: :desc).limit(1).pluck(:zone_1).first || 0 }
            }
  validates :zone_2,
            presence: true,
            numericality: {
              greater_than_or_equal_to: ->(_) { order(created_at: :desc).limit(1).pluck(:zone_2).first || 0 }
            }
  validates :source_type, presence: true

  validate :validate_date

  enum source_type: {
    user: 1,
    controller: 2
  }, _suffix: true

  after_commit :create_bill

  private

  def validate_date
    last_date = self.class.order(created_at: :desc).limit(1).pluck(:date).first
    return if last_date.blank? || last_date <= date

    errors.add(:date, "must be greater or eq #{last_date}")
  end

  def create_bill
    tariff = 168
    zone_1_k = 1
    zone_2_k = 0.5

    prev = EmeterReading.order(date: :desc).limit(1).where(date: ...date).first
    return if prev.blank?

    zone_1_from = prev.zone_1
    zone_1_till = zone_1
    zone_1_consumption = zone_1 - prev.zone_1
    zone_2_from = prev.zone_2
    zone_2_till = zone_2
    zone_2_consumption = zone_2 - prev.zone_2
    zone_1_amount = zone_1_consumption * zone_1_k * tariff
    zone_2_amount = zone_2_consumption * zone_2_k * tariff

    Bill.create(
      from: prev.date,
      till: date,
      zone_1_from: zone_1_from,
      zone_1_till: zone_1_till,
      zone_1: zone_1_consumption,
      zone_2_from: zone_2_from,
      zone_2_till: zone_2_till,
      zone_2: zone_2_consumption,
      tariff: tariff,
      total: zone_1 + zone_2,
      zone_1_amount: zone_1_amount,
      zone_2_amount: zone_2_amount,
      total_amount: zone_1_amount + zone_2_amount
    )
  end
end
