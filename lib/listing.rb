class Listing
  def initialize(name, bio, guest)
    @name = name
    @bio = bio
    @guest = guest
  end

  def self.create_listing(name, bio, guest)
    @listing = Listing.new(name, bio, guest)
  end

  def self.show_listing
    @listing
  end
end
