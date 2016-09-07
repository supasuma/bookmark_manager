require 'rake'
require 'data_mapper'
require 'dm-postgres-adapter'

require '.app/models/tag'
require 'models/link'
namespace :db do

  desc "auto upgrade the database"
  task :upgrade do
    puts "upgrading the database"
    DataMapper.auto_upgrade!
  end
end
