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
set :copy_strategy, :export

namespace :deploy do
	task :start do ; end
	task :stop do ; end
end
