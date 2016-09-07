require 'data_mapper'
require './app/app.rb'

namespace :db do
  desc "Non destuctive upgrade"

  task :auto_upgrade do
    DataMapper.auto_upgrade!
    puts "upgrading the database (no data loss)"
  end

  desc "Destuctive upgrade"
  task :auto_migrate do
    DataMapper.auto_migrate!
    puts "Auto-migrate complete (data was lost)"
  end
end
