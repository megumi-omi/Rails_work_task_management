class Task < ApplicationRecord
  before_create :set_default_deadline

  validates :title, presence: true
  validates :content, presence: true
  
  # scope :

  private
  def set_default_deadline
    self.deadline ||= 7.days.from_now.to_date
    #selfでタスクのインスタンス。（createのsave状態）deadlineを呼んでいる
    #||= 7.days.from_now.to_dateは、終了期限が空の時7日後の値が入る
  end
end
