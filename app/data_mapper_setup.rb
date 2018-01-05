require 'data_mapper'
require 'dm-postgres-adapter'

require 'models/listing'
require 'models/user'

DataMapper.setup(:default, "postgres://localhost/makersbnb_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
