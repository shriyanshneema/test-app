class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :author, class_name: "User"

  validates :body, presence: true
end
