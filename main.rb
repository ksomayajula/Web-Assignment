require 'sinatra'
require 'dm-core'
require 'dm-migrations'
require 'dm-timestamps'
require_relative 'bet'


configure do
  enable :sessions
  set :username, 'sinatra'
  set :password, 'betbig'
end

configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
  DataMapper.auto_migrate!
end

configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
  DataMapper.auto_migrate!
end

get('/styles.css'){scss :styles}

get '/' do
  erb :login
end

get '/login' do
  erb :login
end

post '/login' do
  if params[:username] == "sinatra" && params[:password] == "betbig"
    session[:admin] = true
    redirect to ('/betting')
    else
    erb :login
  end
end
get "/logout" do
  session[:admin] = nil
  redirect to ("/")
end

not_found do
  erb :not_found
end