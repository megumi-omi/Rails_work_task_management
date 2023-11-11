class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy
end
