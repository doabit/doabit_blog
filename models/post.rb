class Post < ActiveRecord::Base
  attr_accessible :title, :content, :slug, :published

  validates :title, :content, :slug, presence: true, uniqueness: true
end
