class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates :email, uniqueness: true
  has_many :tasks, dependent: :destroy
  #これを書くと親親子を作れるらしい
  before_destroy :admin_exist?
  before_destroy :admin_update_ok?
  private


  def admin_exist?
    if User.where(admin: true).count <= 1 && self.admin == true 
      throw(:abort)
    end
  end

  def admin_update_ok?
    if User.where(admin: true).count == 1 && self.admin == false
      throw(:abort)
    end
  end

end
