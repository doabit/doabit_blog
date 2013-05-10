class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :account

  validates :content, presence: true
end
