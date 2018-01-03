ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require './lib/listing.rb'
require 'json'



class Makersbnb < Sinatra::Base

  post '/listings' do
    headers 'Access-Control-Allow-Origin' => '*'
    data = JSON.parse(request.body.read)
    Listing.create_listing(data['name'], data['bio'], data['guests'])
    @listing = Listing.show_listing
    p @listing
  end

  run! if app_file == $0
end
