set :deploy_to, "/var/www/#{application}-stage"
# My Rails app uses RJB, so it needs to know where Java lives
set :domain, "62.76.186.158"
set :user, "akrasman"
set :rails_env, "staging"
# I am root on my staging server and have all the right gems installed
# so I don't need GEM_HOME to be overridden
set :gem_home, nil