# frozen_string_literal: true

class ReportsController < ApplicationController
  def show
    return render_errors('Invalid year for report') unless report_year

    report = ReportService::Generate.call(report_year)

    render json: report.value
  end

  private

  def report_year
    return if params[:year].blank?

    Date.new(Integer(params[:year].to_s))
  rescue ArgumentError
    nil
  end
end
