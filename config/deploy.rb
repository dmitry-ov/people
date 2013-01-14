require 'bundler/capistrano'
require "rvm/capistrano"

set :application, "people"
set :scm, :git
set :repository, "git://github.com/ovcharenkodi/people.git"

server "94.249.192.123", :web, :app, :db, :primary => true

ssh_options[:port] = 22
ssh_options[:keys] = "/home/dmitry/.ssh/id_rsa"

set :user, "dmitry"
default_run_options[:pty] = true
set :deploy_to, "/home/#{user}/app/"
set :use_sudo, false

# RVM's capistrano plugin.    
set :rvm_ruby_string, "1.9.3"
set :rvm_type, :user 

set :deploy_via, :remote_cache
# set :deploy_via, :copy
# set :deploy_via, :checkout
# set :copy_strategy, :export

namespace :deploy do
	task :start do ; end
	task :stop do ; end
end


namespace :dj do
  task :stop, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=production ruby script/delayed_job stop"
    run "ps xu | grep delayed_job | grep monitor | grep -v grep | awk '{print $2}' | xargs -r kill"
  end

  task :start, :roles => :app do
    run "ps xu | grep delayed_job | grep monitor | grep -v grep | awk '{print $2}' | xargs -r kill"
    run "cd #{current_path}; RAILS_ENV=production ruby script/delayed_job start" 
  end

  task :clear, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=production rake jobs:clear" 
  end

  task :status, :roles => :app do
    run "ps xu | grep delayed_job"
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


namespace :passenger do
  desc "Restart Application"  
  task :restart do  
    run "touch #{current_path}/tmp/restart.txt"  
  end
end



after "deploy:stop", "dj:stop"
after "deploy:start", "dj:restart"
after "deploy:start", "passenger:restart"

after "deploy:restart", "dj:restart"
after "deploy", "deploy:cleanup" # keep only the last 5 releases
# after "deploy:start", "whenever:add"

# git ad . && git ci -am 'fix time start dj' && git psh




