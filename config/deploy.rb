set :rvm_type, :user
set :stages, %w(staging production)
set :default_stage, "staging"
set :rvm_ruby_string, 'ruby 1.9.2-p320'
require 'capistrano/ext/multistage'
require "rvm/capistrano"                               # Load RVM's capistrano plugin.

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
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# for some reason, this isn't enabled by default
after "deploy:update", "deploy:cleanup"

# here is an example task which uses rake, as defined above
