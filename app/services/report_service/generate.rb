module ReportService
  class Generate < ApplicationService
    attr_reader :year_end, :year_start, :report

    def initialize(year)
      @year_start = year.at_beginning_of_year
      @year_end = year.at_end_of_year
      @report = { total: 0, total_amount: 0, monthly: {} }
    end

    def call
      report_month = year_start

      while report_month < year_end do
        prev = prev_reading(report_month)
        last = next_reading(report_month.at_end_of_month)

        if prev && last
          days = last.date - prev.date
          diff_1 = last.zone_1 - prev.zone_1
          diff_2 = last.zone_2 - prev.zone_2

          month_days = report_month.at_end_of_month - report_month + 1

          consumption_1 = (diff_1 / days * month_days).to_f
          consumption_2 = (diff_2 / days * month_days).to_f
          total = consumption_1 + consumption_2

          fee_details = FeeService::Calculate.call(consumption_1, consumption_2).value

          report[:monthly][report_month] = fee_details.merge(
            last_date: last.date,
            prev_date: prev.date,
            consumption_1: consumption_1,
            consumption_2: consumption_2,
            total: total
          )

          report[:total] += total
          report[:total_amount] += fee_details[:total_amount]
        end

        report_month += 1.month
      end

      success(report)
    end

    private

    def prev_reading(date)
      EmeterReading.order(date: :desc).limit(1).where(date: ..date).first
    end

    def next_reading(date)
      EmeterReading.order(date: :asc).limit(1).where(date: date..).first
    end
  end
end
