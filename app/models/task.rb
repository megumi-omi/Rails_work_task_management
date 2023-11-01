class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  # scope :deadline, -> {order(deadline: :asc)}
end
