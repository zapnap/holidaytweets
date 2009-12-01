require 'capistrano/version'
require 'rubygems'
load 'deploy' if respond_to?(:namespace) # cap2 differentiator

# standard settings
set :application, "holidaytweets"
set :domain, "holiday.zerosum.org"
role :app, domain
role :web, domain
role :db,  domain, :primary => true

# environment settings
set :user, "deploy"
set :group, "deploy"
set :deploy_to, "/var/www/apps/#{application}"
set :deploy_via, :remote_cache
default_run_options[:pty] = true

# scm settings
set :repository, "git://github.com/zapnap/holidaytweets.git"
set :scm, "git"
set :branch, "master"
set :git_enable_submodules, 1

# where the apache vhost will be generated
set :apache_vhost_dir, "/etc/apache2/sites-enabled/"

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
