require 'data_mapper'
require 'dm-postgres-adapter'

class Listing
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :bio, String
  property :guests, Integer
  property :location, String

end

DataMapper.setup(:default, "postgres://localhost/makersbnb_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
