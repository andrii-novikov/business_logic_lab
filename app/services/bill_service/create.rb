# frozen_string_literal: true

module BillService
  class Create < ApplicationService
    attr_reader :current, :prev

    def initialize(reading)
      @current = reading
      @prev = EmeterReading.where(date: ..reading.date).where('id <> ?', reading.id).last
    end

    def call # rubocop:disable Metrics/AbcSize
      return failure('No previous reading found') if prev.blank?

      zone_1_consumption = current.zone_1 - prev.zone_1
      zone_2_consumption = current.zone_2 - prev.zone_2
      fee_details = FeeService::Calculate.call(zone_1_consumption, zone_2_consumption).value

      bill = Bill.create(
        from: prev.date,
        till: current.date,
        zone_1_from: prev.zone_1,
        zone_1_till: current.zone_1,
        zone_1: zone_1_consumption,
        zone_2_from: prev.zone_2,
        zone_2_till: current.zone_2,
        zone_2: zone_2_consumption,
        total: zone_1_consumption + zone_2_consumption,
        tariff: fee_details[:tariff],
        zone_1_amount: fee_details[:amount_1],
        zone_2_amount: fee_details[:amount_2],
        total_amount: fee_details[:total_amount]
      )

      success(bill)
    end
  end
end
