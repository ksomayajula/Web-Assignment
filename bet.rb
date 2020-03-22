require 'dm-core'
require 'dm-migrations'

class Bet
  include DataMapper::Resource

  property :id, Serial
  property :username, Text
  property :password, Text
  property :sessionwin, Float
  property :sessionloss, Float
  property :sessionprofit, Float
end

configure do
  enable :sessions
  set :username, 'sinatra'
  set :password, 'betbig'
end

DataMapper.finalize


get '/bet' do
  redirect("/login") unless session[:admin]
  erb :betting
  #@sessionwin = 0
  #@sessionloss = 0
  #@sessionprofit = 0
end


post '/bet' do
  redirect("/login") unless session[:admin]
  betamount = params[:betamount].to_i
  betnumber = params[:betnumber].to_i

    roll = rand(6) + 1
    if number == roll
      params[:sessionwin] = 10*betamount
      params[:sessionprofit] = (10*betamount)-(betamount)
      %{<h2>The dice landed on #{roll}, you win #{10*betamount}</h2>}

    else
       params[:sessionloss] = betamount
       params[:sessionprofit] = 0
       %{<h2>The dice landed on #{roll}, you lost #{betamount}</h2>}
    end
  @sessionwin = params[:sessionwin]
  @sessionloss = params[:sessionloss]
  @sessionprofit = params[:sessionprofit]

  erb :betting
end



