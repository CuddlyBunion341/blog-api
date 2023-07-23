class User < ApplicationRecord
  validates :username, presence: true
  validates :email, presence: true

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy

  validates_confirmation_of :password
end
