
source 'http://ruby.taobao.org'

# Project requirements
gem 'rake'

# Component requirements
gem 'carrierwave'
gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'slim'
gem 'activerecord', '>= 3.1', :require => 'active_record'
gem 'sqlite3'

# Padrino Stable Gem
gem 'padrino', '0.11.2'
gem 'tilt', '1.3.7'

# markdown
gem 'redcarpet'
gem 'rouge'

# View
gem "truncate_html", github: 'doabit/truncate_html', branch: 'dev'
gem "html_truncator", "~>0.2"


# Omniauth
gem 'omniauth'
gem 'omniauth-weibo-oauth2', git: 'git://github.com/beenhero/omniauth-weibo-oauth2.git'
gem 'omniauth-github', :git => 'git://github.com/intridea/omniauth-github.git'

gem 'puma'

group :development do
  gem "awesome_print", require: "awesome_print"

  gem 'guard-livereload', "~>1.1.3"
  gem 'rack-livereload', "~>0.3.13"

  gem 'capistrano'
  gem 'capistrano-rbenv', github: 'yyuu/capistrano-rbenv'
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
   gem 'selenium-webdriver'
   gem 'database_cleaner'
   gem 'launchy', require: 'launchy'

   gem 'ffaker'

   gem 'guard-rspec', "~>2.5.2"

    # group :darwin do
    #   gem 'terminal-notifier-guard', :require => false
    #   gem 'rb-fsevent', :require => false
    # end

end
