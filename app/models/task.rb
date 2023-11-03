class Task < ApplicationRecord
  before_create :set_default_deadline

  validates :title, presence: true
  validates :content, presence: true
  
  enum status:{
    waiting: 0, #未着手
    working: 1, #着手
    completed: 2 #完了
  }
  scope :search_title, -> (title) {where("title LIKE ?", "%" + title + "%" )}
  scope :search_status, ->(status) {where(status: status)}

  private
  def set_default_deadline
    self.deadline ||= 7.days.from_now.to_date
    #selfでタスクのインスタンス。（createのsave状態）deadlineを呼んでいる
    #||= 7.days.from_now.to_dateは、終了期限が空の時7日後の値が入る
  end
end
