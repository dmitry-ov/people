require 'bundler/capistrano'
require "rvm/capistrano"

set :application, "people"
set :scm, :git
set :repository, "git://github.com/ovcharenkodi/people.git"

# 1gb Ubuntu server
# server "81.177.142.175", :web, :app, :db, :primary => true

# infobox ubuntu server
server "109.120.166.170", :web, :app, :db, :primary => true


ssh_options[:port] = 22
ssh_options[:keys] = "/home/dmitry/.ssh/id_rsa"

set :user, "dmitry"
default_run_options[:pty] = true
set :deploy_to, "/home/#{user}/app/"
set :use_sudo, false

# set :shell, '/bin/bash'
# default_run_options[:shell] = '/bin/bash'
# /home/dmitry/.rvm/gems/ruby-1.9.3-p327-perf/bin/bundle

# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.    

set :rvm_ruby_string, "1.9.3-p327-perf"
set :rvm_type, :user  # Don't use system-wide RVM










set :deploy_via, :remote_cache
# set :deploy_via, :copy
set :copy_strategy, :export

namespace :deploy do
	task :start do ; end
	task :stop do ; end
	
	# task :t do
	# 	run "rvm reload"
	# end

end



# before "bundle:install", "deploy:t"