require 'data_mapper'
require 'dm-postgres-adapter'

class Listing
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :bio, String
  property :guests, Integer

end

DataMapper.setup(:default, "postgres://localhost/makersbnb_test")
DataMapper.finalize
DataMapper.auto_upgrade!
