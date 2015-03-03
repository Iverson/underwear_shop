server '109.234.36.44', user: 'deploy', roles: [:web, :app, :db], primary: true
set :branch, ENV['BRANCH'] || 'feature/puma'