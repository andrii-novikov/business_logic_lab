# frozen_string_literal: true

class ApplicationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_reader :object

  def initialize(obj, attributes = nil)
    super(attributes)

    @object = obj
  end

  def save
    return false unless valid?

    persist!
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.to_s)
    false
  end

  def persist!
    raise NotImplementedError
  end
end
