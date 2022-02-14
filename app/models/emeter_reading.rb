# frozen_string_literal: true

class EmeterReading < ApplicationRecord
  enum source_type: {
    user: 1,
    controller: 2
  }, _suffix: true
end
