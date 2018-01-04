ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require './lib/listing.rb'
require 'json'

class Makersbnb < Sinatra::Base


  get '/listings' do
    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
    listing = Listing.new('Leafy Towers', 'Tall and Leafy', 2)
    listing2 = Listing.new('Rocky Towers', 'Tall and Rocky', 2)
    @listing3 = Listing.show_listing
    if !!@listing3
      entries = [listing, listing2, @listing3]
    else
      entries = [listing, listing2]
    end
    entries.map{ |entry| { name: entry.name, bio: entry.bio, guests: entry.guests }}.to_json
  end

  post '/listings' do
    headers 'Access-Control-Allow-Origin' => '*'
    data = JSON.parse(request.body.read)
    Listing.create_listing(data['name'], data['bio'], data['guests'])
  end

  run! if app_file == $0
end
