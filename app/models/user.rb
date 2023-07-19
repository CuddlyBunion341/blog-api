class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true
  validates :email, presence: true

  has_many :posts, foreign_key: :author_id, dependent: :destroy
end
