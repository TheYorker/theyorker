set :application, "theyorker.co.uk"

set :repository,  "git://github.com/TheYorker/theyorker.git"
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache

set :user, "theyorker"
set :use_sudo, false

set :deploy_to, "/home/#{user}/apps/#{application}"


# rvm
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, "ruby-1.9.2@#{user}"        # Or whatever env you want it to run in.

# assets
load 'deploy/assets'

# bundler

set :domain, "qlkzy.net"
role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run


# passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# clean up old releases after deploying
after "deploy", "deploy:cleanup"
