# frozen_string_literal: true

class EmeterReadingsController < ApplicationController
  def index
    @meters = EmeterReading.order(id: :desc)
    render json: @meters
  end

  def create
    @form = EmeterReadingForm.new(EmeterReading.new, create_params)

    if @form.save
      result = BillService::Create.call(@form.object)
      logger.warn('Bill was not created') if result.failure?

      render json: @form.object
    else
      render_errors @form.errors
    end
  end

  private

  def create_params
    params.permit(:date, :zone_1, :zone_2)
  end
end
