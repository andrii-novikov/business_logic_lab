# frozen_string_literal: true

module Admin
  class EmeterReadingForm < ApplicationForm
    attribute :date, :date
    attribute :zone_1, :big_integer
    attribute :zone_2, :big_integer

    validates :date, :zone_1, :zone_2, presence: true

    def persist!
      @object.update!(date: date, zone_1: zone_1, zone_2: zone_2, source_type: :controller)
    end
  end
end
