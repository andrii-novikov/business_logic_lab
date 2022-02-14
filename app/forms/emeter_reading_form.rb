# frozen_string_literal: true

class EmeterReadingForm < ApplicationForm
  attr_reader :previous

  attribute :date, :date
  attribute :zone_1, :big_integer
  attribute :zone_2, :big_integer

  validates :date, presence: true
  validates :zone_1,
            presence: true,
            numericality: {
              greater_than_or_equal_to: ->(f) { f.previous&.zone_1 || 0 }
            }
  validates :zone_2,
            presence: true,
            numericality: {
              greater_than_or_equal_to: ->(f) { f.previous&.zone_2 || 0 }
            }
  validate :validate_date
  validate :validate_duplicate

  def initialize(reading = EmeterReading.new, attributes = nil)
    super

    @previous = EmeterReading.last
  end

  def persist!
    @object.update!(date: date, zone_1: zone_1, zone_2: zone_2, source_type: :user)
  end

  private

  def validate_date
    return if @previous&.date.blank? || @previous.date <= date

    errors.add(:date, "must be greater or eq #{@previous.date}")
  end

  def validate_duplicate
    return if @previous.blank?
    return if @previous.zone_1 != zone_1 || @previous.zone_2 != zone_2 || @previous.date != date

    errors.add(:base, 'Duplicate reading')
  end
end
