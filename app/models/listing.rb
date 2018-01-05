class Listing
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :bio, String
  property :guests, Integer
  property :location, String

end
