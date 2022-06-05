class User < ApplicationRecord
  has_secure_password

  has_many :posts, foreign_key: "author_id", dependent: :destroy
  has_many :comments, foreign_key: "author_id"

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || password.present? }
end
