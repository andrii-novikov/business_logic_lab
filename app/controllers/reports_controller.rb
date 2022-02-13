class ReportsController < ApplicationController
  def show
    return render_errors('Invalid year for report') unless report_year

    report = {
      total: 0,
      total_amount: 0,
      monthly: {}
    }

    report_month = report_year

    while report_month < report_year.at_end_of_year do
      prev = prev_report(report_month)
      last = next_report(report_month.at_end_of_month)

      days = last.date - prev.date
      month_days = report_month.at_end_of_month - report_month + 1
      diff_1 = last.zone_1 - prev.zone_1
      diff_2 = last.zone_2 - prev.zone_2

      zone_1 = (diff_1 / days * month_days).to_f
      zone_2 = (diff_2 / days * month_days).to_f
      total = zone_1 + zone_2

      tariff = 1.68
      zone_1_k = 1
      zone_2_k = 0.5

      amount_1 = tariff * zone_1 * zone_1_k
      amount_2 = tariff * zone_2 * zone_2_k
      total_amount = amount_1 + amount_2

      report[:monthly][report_month] = {
        last_date: last.date,
        prev_date: prev.date,
        zone_1: zone_1,
        zone_2: zone_2,
        total: total,
        amount_1: amount_1,
        amount_2: amount_2,
        total_amount: total_amount
      }
      report[:total] += total
      report[:total_amount] += total_amount
      report_month += 1.month
    end

    render json: report
  end

  private

  def report_year
    return if params[:year].blank?

    Date.new(Integer(params[:year].to_s))
  rescue ArgumentError
    nil
  end

  def prev_report(date)
    EmeterReading.order(date: :desc).limit(1).where(date: ..date).first
  end

  def next_report(date)
    EmeterReading.order(date: :asc).limit(1).where(date: date..).first
  end
end
