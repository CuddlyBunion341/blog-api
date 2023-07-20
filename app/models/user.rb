class User < ApplicationRecord
  validates :username, presence: true
  validates :email, presence: true

  has_many :posts, foreign_key: :author_id, dependent: :destroy

  devise :database_authenticatable, :registerable, :validatable
end
