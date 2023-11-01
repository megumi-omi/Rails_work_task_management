class Task < ApplicationRecord
  before_create :set_default_deadline

  validates :title, presence: true
  validates :content, presence: true

  private
  def set_default_deadline
    self.deadline ||= 7.days.from_now.to_date
  end
end
