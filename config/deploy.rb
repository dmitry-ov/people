require 'bundler/capistrano'

load "config/recipes/rvm_prepare"
load "config/recipes/passenger.rb"

set :application, "people"
set :scm, :git
set :repository, "git://github.com/ovcharenkodi/people.git"

server "81.177.142.175", :web, :app, :db, :primary => true

ssh_options[:port] = 22
ssh_options[:keys] = "/home/dmitry/.ssh/id_rsa"

set :user, "dmitry"
default_run_options[:pty] = true
set :deploy_to, "/home/#{user}/app/"
set :use_sudo, false

set :deploy_via, :remote_cache
# set :deploy_via, :copy
set :copy_strategy, :export

namespace :deploy do
	task :start do ; end
	task :stop do ; end
end