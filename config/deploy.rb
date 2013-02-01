require 'bundler/capistrano'
require "rvm/capistrano"

set :application, "people"
set :scm, :git
set :repository, "git://github.com/ovcharenkodi/people.git"

server "178.79.130.207", :web, :app, :db, :primary => true

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
  desc "delayed_job stop"
  task :stop, :roles => :app do
    run "cd #{deploy_to}curent; RAILS_ENV=production ruby script/delayed_job stop"
    run "ps xu | grep delayed_job | grep monitor | grep -v grep | awk '{print $2}' | xargs -r kill"
  end

  desc "delayed_job start"
  task :start, :roles => :app do
    run "ps xu | grep delayed_job | grep monitor | grep -v grep | awk '{print $2}' | xargs -r kill"
    run "cd #{current_path}; RAILS_ENV=production ruby script/delayed_job start" 
  end

  desc "clear delayed_job queue"
  task :clear, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=production rake jobs:clear" 
  end

  desc "status delayed_job"
  task :status, :roles => :app do
    run "ps xu | grep delayed_job"
  end

  desc "Add to queue fetch job"
  task :fetch do
    run "cd #{current_path}; script/rails runner -e production 'Statistic.fetch'" 
  end

  task :restart, :roles => :app do
    stop
    start
  end
end


namespace :whenever do
  desc "whenever add jobs from config/schedule.rb to crontab"
  task :add, :roles => :app do
    run "cd #{current_path} && whenever --update-crontab"
  end

  desc "whenever clear all jobs from crontab"
  task :clear, :roles => :app do
    run "cd #{current_path} && bundle exec whenever -c" # не работает
  end

  desc "whenever rewrite"
  task :rewrite, :roles => :app do
    clear
    add
  end
end


namespace :passenger do
  desc "Restart passenger server"  
  task :restart do  
    run "touch #{current_path}/tmp/restart.txt"  
  end
end



before "deploy", "whenever:clear"


after "deploy", "whenever:add"
after "deploy", "dj:restart"
after "deploy", "passenger:restart"


after "deploy", "deploy:cleanup" # keep only the last 5 releases


# git ad . && git ci -am 'fix' && git psh




