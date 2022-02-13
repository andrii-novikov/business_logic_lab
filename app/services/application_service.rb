class ApplicationService
  def self.call(*args, **opts, &block)
    new(*args, **opts, &block).call
  end

  private

  def failure(error)
    ServiceResult.new(error: error)
  end

  def success(value = nil)
    ServiceResult.new(value: value)
  end
end
