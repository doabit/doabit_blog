FactoryGirl.define do
  factory :post do
    sequence(:title) {|n| "Title #{n}" }
    sequence(:content) {|n| "#{'content' * 30} #{n}" }
    published false
    sequence(:slug) {|n| "slug-#{n}" }
  end #post

  factory :tag do
    sequence(:name) {|n| "name #{n}" }
  end #tag

end