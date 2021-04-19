require 'sinatra'

class RockPaperScissors < Sinatra::Base

enable :sessions

  get '/' do
    erb :layout
  end

  post '/' do
    session['player_name'] = params[:player_name]
    @player_name = session['player_name']
    erb :layout
  end


end
