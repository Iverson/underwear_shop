set :deploy_to, "/home/akrasman/#{application}-production"
# My Rails app uses RJB, so it needs to know where Java lives
set :domain, "62.76.186.158"
server domain, :app, :web, :db, :primary => true
set :user, "akrasman"
set :rails_env, "production"
# I am root on my staging server and have all the right gems installed
# so I don't need GEM_HOME to be overridden
set :gem_home, nil