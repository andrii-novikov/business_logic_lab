# frozen_string_literal: true

class ServiceResult
  attr_reader :error, :value

  def initialize(value: nil, error: nil)
    @value = value
    @error = error
  end

  def success?
    error.blank?
  end

  def failure?
    !success?
  end
end
