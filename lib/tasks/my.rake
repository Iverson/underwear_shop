# encoding: utf-8

namespace :db do
  desc "Import DB from production"
  task :import do
    require 'YAML'

    dump_path = "tmp/prod.sql"
    db_config = YAML::load(IO.read("config/database.yml"))
    db_config_prod = db_config["production"]
    db_config_dev = db_config["development"]

    puts "Lets go!"
    puts "Reset local DB..."
    %x(rake db:drop && rake db:create)
    puts "Making dump production DB, rsync and import to local DB..."
    %x(cap production invoke COMMAND="pg_dump -U #{db_config_prod["username"]} #{db_config_prod["database"]} > ~/younglovers-production/current/#{dump_path}" && rsync -avz akrasman@62.76.186.158:~/younglovers-production/current/#{dump_path} #{dump_path} && psql #{db_config_dev["database"]} < #{dump_path})
    puts "Finished!"
  end
end