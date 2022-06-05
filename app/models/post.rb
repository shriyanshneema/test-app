class Post < ApplicationRecord
  belongs_to :author, class_name: "User"

  enum tag: %i(tag1 tag2 tag3)

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true

  def has_any_comment?
    comments_count > 0
  end
end
