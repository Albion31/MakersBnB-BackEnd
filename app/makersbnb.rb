ENV["RACK_ENV"] ||= "development"
# DataMapper.setup(:default, "postgres://localhost/makersbnb_#{ENV["RACK_ENV"]}")
require_relative 'data_mapper_setup'
require 'sinatra/base'
require_relative './models/listing.rb'
require 'json'
require 'pry'

class Makersbnb < Sinatra::Base
  set :public_folder, 'public'
  enable :sessions
  set :session_secret, 'super secret'

  helpers do
    def current_user
      p session[:username]
      #binding.pry
      @current_user ||= User.first(username: session[:username])
    end
  end

  get '/' do
    File.read(File.join('public', 'home.html'))
  end

  get '/listings' do
    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
    entries = Listing.all
    # p current_user.username
    entries.map{ |entry| { name: entry.name, bio: entry.bio, guests: entry.guests, location: entry.location }}.to_json
  end

  post '/listings' do
    headers 'Access-Control-Allow-Origin' => '*'
    data = JSON.parse(request.body.read)
    Listing.create(name: data['name'], bio: data['bio'],guests: data['guests'], location: data['location'])
  end

  get '/users' do
    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
    if !!current_user
      {username: current_user.username}.to_json
    end
  end

  post '/users' do
    headers 'Access-Control-Allow-Origin' => '*'
    data = JSON.parse(request.body.read)
    user = User.create(username: data['username'], email: data['email'], password: data['password'], password_confirmation: data['password_confirmation'])
    p user
    session[:username] = user.username
  end

  run! if app_file == $0
end
