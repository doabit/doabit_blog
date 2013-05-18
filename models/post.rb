# encoding: UTF-8
class Post < ActiveRecord::Base
  attr_accessible :title, :content, :slug, :published, :tag_list, :published_at_string

  validates :title, :content, :slug, presence: true, uniqueness: true

  has_many :taggings
  has_many :tags, through: :taggings

  has_many :comments, :dependent => :destroy


  scope :published, -> { where(published: true) }

  def to_param
    [id, slug.parameterize].join('-')
  end

   def self.tagged_with(name)
     Tag.find_by_name!(name).posts
   end

   def self.tag_counts
     Tag.select("tags.*, count(taggings.tag_id) as count").
       joins(:taggings).group("taggings.tag_id")
   end

   def tag_list
     tags.map(&:name).join(", ")
   end

   def tag_list=(names)
     self.tags = names.split(",").map do |n|
       Tag.where(name: n.strip).first_or_initialize
     end
   end


   # published_at
   def published_at_string
     published_at ? published_at.to_s(:db) : Time.now.to_s(:db)
   end

   def published_at_string=(published_at_str)
     self.published_at = Time.parse(published_at_str)
   rescue ArgumentError
     @published_at_invalid = true
   end

   validate :must_be_date

   def must_be_date
     errors.add(:published_at_string, "格式不正确") if @published_at_invalid
   end
end
