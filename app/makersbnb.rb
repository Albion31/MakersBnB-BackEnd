ENV["RACK_ENV"] ||= "development"
# DataMapper.setup(:default, "postgres://localhost/makersbnb_#{ENV["RACK_ENV"]}")
require_relative 'data_mapper_setup'
require 'sinatra/base'
require_relative './models/listing.rb'
require 'json'

class Makersbnb < Sinatra::Base
  set :public_folder, 'public'
  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    File.read(File.join('public', 'home.html'))
  end

  get '/listings' do
    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
    entries = Listing.all
    #user = User.
    entries.map{ |entry| { name: entry.name, bio: entry.bio, guests: entry.guests, location: entry.location }}.to_json
  end

  post '/listings' do
    headers 'Access-Control-Allow-Origin' => '*'
    data = JSON.parse(request.body.read)
    Listing.create(name: data['name'], bio: data['bio'],guests: data['guests'], location: data['location'])
    p Listing.last
  end

  post '/users' do
    headers 'Access-Control-Allow-Origin' => '*'
    User.create(username: data['username'], email: data['email'], password: data['password'])
    session[:username] = data['username']
  end

  run! if app_file == $0
end
