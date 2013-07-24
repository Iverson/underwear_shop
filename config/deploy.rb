require "bundler/capistrano"
set :rvm_type, :user
set :stages, %w(staging production)
set :default_stage, "staging"
set :rvm_ruby_string, 'ruby 1.9.2-p320'
set :whenever_environment, defer { stage }
set :whenever_identifier, defer { "#{application}_#{stage}" }
set :whenever_roles, "app"
set :whenever_command, "bundle exec whenever"
require 'capistrano/ext/multistage'
require "rvm/capistrano"                              # Load RVM's capistrano plugin.
require 'thinking_sphinx/deploy/capistrano'
require "whenever/capistrano"

default_run_options[:pty] = true

set :application, "younglovers"
set :use_sudo, false
set :keep_releases, 5

set :repository,  "git@github.com:Iverson/underwear_shop.git"
set :branch, "master"
set :scm, :git
set :deploy_via, :remote_cache

# this is useful in a shared hosting environment, where you have your own JAVA_HOME or GEM_HOME.
# otherwise, just set RAILS_ENV
set(:rake) { "bundle exec rake" }

# since :domain is defined in another file (staging.rb and production.rb),
# we need to delay its assignment until they're loaded


before 'deploy:setup', 'rvm:install_ruby'
after "deploy:update_code", "deploy:migrate"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  
  desc "Restart Application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

# for some reason, this isn't enabled by default
after "deploy", "deploy:cleanup"

# Sphinx
before 'deploy:update_code', 'thinking_sphinx:stop'
after  'deploy:update_code', 'thinking_sphinx:start'

namespace :sphinx do
  desc "Symlink Sphinx indexes"
  task :symlink_indexes, :roles => [:app] do
    run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
  end
end

after 'deploy:finalize_update', 'sphinx:symlink_indexes'

# Swap in the maintenance page
namespace :web do
  desc "Up maintenance.html"
  task :disable, :roles => :web do
    on_rollback { run "rm #{shared_path}/system/maintenance.html" }

    run "if [[ !(-f #{shared_path}/system/maintenance.html) ]] ; then ln -s #{shared_path}/system/maintenance.html.not_active #{shared_path}/system/maintenance.html ; else echo 'maintenance page already up'; fi"
  end
  
  desc "Down maintenance.html"
  task :enable, :roles => :web do
    run "rm #{shared_path}/system/maintenance.html"
  end
end

require './config/boot'
require 'airbrake/capistrano'
