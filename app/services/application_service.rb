# frozen_string_literal: true

class ApplicationService
  def self.call(...)
    new(...).call
  end

  private

  def failure(error)
    ServiceResult.new(error: error)
  end

  def success(value = nil)
    ServiceResult.new(value: value)
  end
end
