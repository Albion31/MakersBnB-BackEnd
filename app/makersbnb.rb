ENV["RACK_ENV"] ||= "development"
# DataMapper.setup(:default, "postgres://localhost/makersbnb_#{ENV["RACK_ENV"]}")
require_relative 'data_mapper_setup'
require 'sinatra/base'
require_relative './models/listing.rb'
# require_relative '../lib/listing.rb'
require 'json'

class Makersbnb < Sinatra::Base


  get '/listings' do
    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
    entries = Listing.all
    entries.map{ |entry| { name: entry.name, bio: entry.bio, guests: entry.guests, location: entry.location }}.to_json
  end

  post '/listings' do
    headers 'Access-Control-Allow-Origin' => '*'
    data = JSON.parse(request.body.read)
    Listing.create(name: data['name'], bio: data['bio'],guests: data['guests'], location: data['location'])
    p Listing.last
  end

  run! if app_file == $0
end
