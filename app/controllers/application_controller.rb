# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def render_errors(errors)
    render json: { errors: Array(errors) }
  end
end
