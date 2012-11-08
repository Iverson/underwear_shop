set :deploy_to, "/var/www/#{application}-prod"
set :domain, "62.76.186.158"
set :user, "myuser"
set :rails_env, "production"
set :gem_home, "/home/myuser/ruby/gems/"

# in a shared hosting environment, you often need to specify your own passenger configuration
desc "copy the .htaccess file (passenger configuration); setup_load_paths.rb (sets GEM_HOME)"
namespace :deploy do
  task :copy_htaccess do
    run "cp #{current_release}/config/htaccess_production #{current_release}/public/.htaccess"
    run "mv #{current_release}/config/production_setup_load_paths.rb #{current_release}/config/setup_load_paths.rb"
  end
end

after "deploy:update_code", "deploy:copy_htaccess"