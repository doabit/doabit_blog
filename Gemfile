
source 'https://rubygems.org'

# Project requirements
gem 'rake'

# Component requirements
gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'slim'
gem 'activerecord', '>= 3.1', :require => 'active_record'
gem 'sqlite3'

# Padrino Stable Gem
gem 'padrino', '0.11.1'


# markdown
gem 'redcarpet'
gem 'rouge'
group :development do
  gem "awesome_print", require: "awesome_print"

  gem 'guard-livereload', "~>1.1.3"
  gem 'rack-livereload', "~>0.3.13"

  gem 'guard-rspec', "~>2.5.2"

  if RUBY_PLATFORM =~ /darwin/i
    gem 'terminal-notifier-guard'
    gem 'rb-fsevent', :require => false
  end
end


# Test requirements
group :test do
   gem 'rspec', "~>2.13.0"
   gem 'rack-test', :require => 'rack/test'
   gem 'factory_girl'
   gem "shoulda-matchers", "~>1.5.6"

   gem 'capybara', github: 'jnicklas/capybara'
   gem 'capybara-padrino', github: 'doabit/capybara-padrino'
   # gem 'capybara-webkit', github: 'thoughtbot/capybara-webkit'
   gem 'database_cleaner'
   gem 'launchy', require: 'launchy'

   gem 'ffaker'
end
