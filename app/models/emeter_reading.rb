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

  private

  def validate_date
    last_date = self.class.order(created_at: :desc).limit(1).pluck(:date).first
    return if last_date.blank? || last_date <= date

    errors.add(:date, "must be greater or eq #{last_date}")
  end
end
