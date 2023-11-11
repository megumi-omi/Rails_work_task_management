class Task < ApplicationRecord
  before_create :set_default_deadline

  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labelling_labels, through: :labellings, source: :label

  validates :title, presence: true
  validates :content, presence: true
  
  enum status: { waiting: 0, working: 1, completed: 2 }
  enum priority: { high: 0, medium: 1, low: 2 }

  scope :search_title, -> (title) {where("title LIKE ?", "%" + title + "%" )}
  scope :search_status, ->(status) {where(status: status)}

  private
  def set_default_deadline
    self.deadline ||= 7.days.from_now.to_date
    #selfでタスクのインスタンス。（createのsave状態）deadlineを呼んでいる
    #||= 7.days.from_now.to_dateは、終了期限が空の時7日後の値が入る
  end
end
