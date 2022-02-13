module FeeService
  class Calculate < ApplicationService
    TARIFF = 168
    ZONE_1_K = 1
    ZONE_2_K = 0.5

    attr_reader :consumption_1, :consumption_2, :tariff

    def initialize(consumption_1, consumption_2, tariff: TARIFF)
      @consumption_1 = consumption_1
      @consumption_2 = consumption_2
      @tariff = tariff
    end

    def call
      amount_1 = tariff * consumption_1 * ZONE_1_K
      amount_2 = tariff * consumption_2 * ZONE_2_K

      success(
        tariff: tariff,
        amount_1: amount_1,
        amount_2: amount_2,
        total_amount: amount_1 + amount_2
      )
    end
  end
end
