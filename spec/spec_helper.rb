# encoding UTF-8
require 'capybara/rspec'
require 'capybara/padrino/rspec'
require 'database_cleaner'

PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

Capybara.javascript_driver = :webkit
Capybara.asset_host = "http://localhost:3000"



OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:weibo] = OmniAuth::AuthHash.new({
                                                            :provider => 'weibo',
                                                            :uid => '1337',
                                                            :info => {
                                                                'nickname' => 'weibo_uname',
                                                                'image' => 'http://weibo.dev/1.png',
                                                                'urls' => {"Weibo" => 'http://www.weibo.com/weibo_uname'}
                                                            }
                                                        })
OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
                                                            :provider => 'github',
                                                            :uid => '1338',
                                                            :info => {
                                                                'nickname' => 'github_uname',
                                                                'image' => 'http://github.dev/1.png',
                                                                'urls' => {"GitHub" => 'http://www.github.com/github_uname'}
                                                            }
                                                        })


RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryGirl::Syntax::Methods


  config.before(:suite) do
     DatabaseCleaner.strategy = :truncation
     DatabaseCleaner.clean_with(:truncation)
   end

   config.before(:each) do
     DatabaseCleaner.start
   end

   config.after(:each) do
     DatabaseCleaner.clean
   end

   def login_with(link)
     visit "/"
     click_link(link)
   end

   def add_comment(post)
     FileUtils.rm_rf(Dir['tmp/**/cache'])
     visit '/posts'
     click_link post.title
     within("#new_comment") do
       fill_in "comment_content", with: 'this is comment'
     end
     click_button '发表评论'
   end

end


# Factory_girl
FactoryGirl.definition_file_paths = [
    File.join(Padrino.root, 'factories'),
    File.join(Padrino.root, 'spec', 'factories')
]
FactoryGirl.find_definitions

def app
  DoabitBlog::App.tap { |app|  }
end
