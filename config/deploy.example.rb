require "bundler/capistrano"
require 'puma/capistrano'

server "doabit.com", :web, :app, :db, primary: true

set :application, "doabit.com"
set :user, "user"
set :group, "group"
set :deploy_to, "/home/user/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git://github.com/doabit/doabit_blog.git"
set :branch, "master"

set :shared_children, shared_children + %w{public/uploads}

require "capistrano-rbenv"
set :rbenv_ruby_version, "2.0.0-p195"

after "deploy:restart", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do

  task :migrate do
    run "cd #{current_path}; PADRINO_ENV=production bundle exec rake ar:migrate"
  end

  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/app_config.example.yml"), "#{shared_path}/config/app_config.yml"
    put File.read("config/nginx.example.conf"), "#{shared_path}/config/nginx.conf"
    sudo "ln -nfs #{shared_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}.conf"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/app_config.yml #{release_path}/config/app_config.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end