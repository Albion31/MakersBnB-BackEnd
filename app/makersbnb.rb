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
    # p current_user.username
    entries.map{ |entry| { name: entry.name, bio: entry.bio, guests: entry.guests, location: entry.location }}.to_json
  end

  post '/listings' do
    headers 'Access-Control-Allow-Origin' => '*'
    data = JSON.parse(request.body.read)
    Listing.create(name: data['name'], bio: data['bio'],guests: data['guests'], location: data['location'])
    p Listing.last
  end

  get '/users' do
    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
    p current_user
    {username: current_user.username}.to_json if !!current_user

  end

  post '/users' do
    #begin
      headers 'Access-Control-Allow-Origin' => '*'
      data = JSON.parse(request.body.read)
      user = User.create(username: data['username'], email: data['email'], password: data['password'])
      session[:username] = user.username
      p session[:username]
    #  session[:user_id] = user.id
    #rescue Exception => e
      #p e.message
      #p e.backtrace.inspect
    #end
    # {user_id: user.id}.to_json
  end

  run! if app_file == $0
end
