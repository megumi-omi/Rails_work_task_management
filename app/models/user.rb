class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  before_update :admin_update_exist
  before_destroy :admin_destroy_check

  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 30}
  validates :email, presence: true, length: { maximum: 255},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :cteate
  
  has_secure_password

  private
  def admin_update_exist
    if User.where(admin: true).count <= 1 && self.admin == false
      throw :abort
    end
  end

  def admin_destroy_check
    if User.where(admin: true).count <= 1 && self.admin == true
      throw(:abort)
    end
  end
end
