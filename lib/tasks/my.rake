# encoding: utf-8

namespace :db do
  desc "Import DB from production"
  task :import do
    require 'YAML'

    dump_path = "tmp/prod.dump"
    db_config = YAML::load(IO.read("config/database.yml"))
    db_config_prod = db_config["production"]
    db_config_dev = db_config["development"]
    remote_user = "deploy"
    remote_address = "109.234.36.44"

    puts "Lets go!"
    puts "Reset local DB..."
    %x(rake db:drop && rake db:create)
    puts "Making dump production DB, rsync and import to local DB..."
    %x(rsync -avz #{remote_user}@#{remote_address}:~/prod.dump #{dump_path} && psql #{db_config_dev["database"]} < #{dump_path})
    puts "Finished!"
  end
end

desc "Import Static from production"
task :static do
  puts "Rsync..."
  %x(rsync --progress -zvr #{remote_user}@#{remote_address}:/www/younglovers/shared/system/ public/system/)
  puts "Finished!"
end