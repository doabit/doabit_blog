class Post < ActiveRecord::Base
  attr_accessible :title, :content, :slug, :published, :tag_list

  validates :title, :content, :slug, presence: true, uniqueness: true

  has_many :taggings
  has_many :tags, through: :taggings

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
end
