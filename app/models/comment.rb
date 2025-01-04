class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :post
  has_rich_text :content
end
