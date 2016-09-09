require 'data_mapper'
require 'dm-postgres-adapter'

require_relative 'models/tag'
require_relative 'models/link'
require_relative 'models/user'

ENV['RACK_ENV']||= "development"


DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper::Logger.new($stdout, :debug)
DataMapper.finalize

DataMapper.auto_upgrade!
