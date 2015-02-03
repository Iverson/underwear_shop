server '127.0.0.1', user: 'deploy', port: 2222, roles: [:web, :app, :db], primary: true
set :branch, ENV['BRANCH'] || 'feature/puma'