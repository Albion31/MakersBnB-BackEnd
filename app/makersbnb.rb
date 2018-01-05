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
    entries.map{ |entry| { name: entry.name, bio: entry.bio, guests: entry.guests, location: entry.location }}.to_json
  end

  post '/listings' do
    headers 'Access-Control-Allow-Origin' => '*'
    data = JSON.parse(request.body.read)
    Listing.create(name: data['name'], bio: data['bio'],guests: data['guests'], location: data['location'])
  end

  get '/users/current-user' do
    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
    if !!current_user
      {username: current_user.username}.to_json
    end
  end

  post '/users/new' do
    headers 'Access-Control-Allow-Origin' => '*'
    data = JSON.parse(request.body.read)
    user = User.create(username: data['username'], email: data['email'], password: data['password'], password_confirmation: data['password_confirmation'])
    session[:username] = user.username
  end

  post '/users/sign-in' do
    headers 'Access-Control-Allow-Origin' => '*'
    data = JSON.parse(request.body.read)
    user = User.authenticate(data['username'], data['password'])
    if !!user
      session[:username] = user.username
      redirect '/'
    end
  end

  get '/users/sign-out' do
    session[:username] = nil
    redirect '/'
  end

  run! if app_file == $0
end
