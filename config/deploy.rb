require 'bundler/capistrano'
require "rvm/capistrano"

set :application, "people"
set :scm, :git
set :repository, "git://github.com/ovcharenkodi/people.git"

# 1gb Ubuntu server
server "81.177.142.175", :web, :app, :db, :primary => true

# infobox ubuntu server
# server "109.120.166.170", :web, :app, :db, :primary => true

ssh_options[:port] = 22
ssh_options[:keys] = "/home/dmitry/.ssh/id_rsa"

set :user, "dmitry"
default_run_options[:pty] = true
set :deploy_to, "/home/#{user}/app/"
set :use_sudo, false

# RVM's capistrano plugin.    
set :rvm_ruby_string, "1.9.3-p327-perf"
set :rvm_type, :user 

set :deploy_via, :remote_cache
# set :deploy_via, :copy
# set :deploy_via, :checkout
# set :copy_strategy, :export

namespace :deploy do
	task :start do ; end
	task :stop do ; end
end


namespace :delayed_job do
  task :stop, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=production ruby script/delayed_job stop"
  end

  task :start, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=production ruby script/delayed_job start" 
  end

  task :restart, :roles => :app do
    stop
    start
  end
end


namespace :whenever do
  desc "whenever add jobs from config/schedule.rb to crontab"
  task :add, :roles => :app do
    run "cd #{current_path} && bundle exec whenever --set 'environment=production' --update-crontab"    
  end

  desc "whenever clear all jobs from crontab"
  task :clear, :roles => :app do
    run "cd #{current_path} && bundle exec whenever -c"
  end

  desc "whenever rewrite"
  task :rewrite, :roles => :app do
    clear
    add
  end
end


after "deploy:stop", "delayed_job:stop"

after "deploy:start", "delayed_job:restart"
after "deploy:start", "whenever:rewrite"

after "deploy:restart", "delayed_job:restart"

after "deploy", "deploy:cleanup" # keep only the last 5 releases

