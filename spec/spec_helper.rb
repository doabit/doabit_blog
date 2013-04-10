# encoding UTF-8
require 'capybara/rspec'
require 'capybara/padrino/rspec'
require 'database_cleaner'

PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

Capybara.javascript_driver = :webkit
Capybara.asset_host = "http://localhost:3000"

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:suite) do
     DatabaseCleaner.strategy = :truncation
   end

   config.before(:each) do
     DatabaseCleaner.start
   end

   config.after(:each) do
     DatabaseCleaner.clean
   end
end

def app
  DoabitBlog::App.tap { |app|  }
end
