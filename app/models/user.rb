class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true
  validates :email, presence: true

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy

  validates_confirmation_of :password
  validates_presence_of :password, on: :create
end
