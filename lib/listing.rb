class Listing
  attr_reader :name, :bio, :guests
  def initialize(name, bio, guests)
    @name = name
    @bio = bio
    @guests = guests
  end

  def self.create_listing(name, bio, guests)
    @listing = Listing.new(name, bio, guests)
  end

  def self.show_listing
    @listing
  end
end
