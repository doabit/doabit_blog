FactoryGirl.define do
  factory :post do
    title Faker::Lorem.words(10)
    content  Faker::Lorem.words(50)
    published false
    slug Faker::Lorem.words(20)
  end #post

  factory :tag do
    name Faker::Lorem.words(1)
  end #tag

end