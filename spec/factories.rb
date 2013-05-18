FactoryGirl.define do
  factory :post do
    sequence(:title) {|n| "Title #{n}" }
    sequence(:content) {|n| "#{'content' * 30} #{n}" }
    published true
    published_at Time.now
    sequence(:slug) {|n| "slug-#{n}" }
  end #post

  factory :tag do
    sequence(:name) {|n| "name #{n}" }
  end #tag

  factory :account do
    name 'name'
    email Faker::Internet.email
    password 'password'
    password_confirmation 'password'
    role 'commenter'
  end #post

  factory :comment do
    account
    post
    content Faker::LoremCN.paragraph
  end

end