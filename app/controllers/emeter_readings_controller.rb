class EmeterReadingsController < ApplicationController
  def index
    @meters = EmeterReading.all
    render json: @meters
  end

  def create
    @meter = EmeterReading.new(create_params)
    @meter.date ||= Time.now
    @meter.source_type = :user

    if @meter.save
      render json: @meter
    else
      render_errors @meter.errors
    end
  end

  private

  def create_params
    params.permit(:date, :zone_1, :zone_2, :source_type)
  end
end
