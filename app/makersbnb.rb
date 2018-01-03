ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require './lib/listing.rb'


class Makersbnb < Sinatra::Base

  post '/listings' do
    puts Listing.create_listing(params[:name], params[:bio], params[:guests])
  end

  run! if app_file == $0
end
