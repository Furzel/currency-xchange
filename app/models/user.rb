class User < ActiveRecord::Base
  validates :name, presence: true, length: {maximum: 255}
  validates :email, presence: true, length: {maximum: 255}, format: {with: /[^@]*@.*/}, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}

  has_secure_password
end
