require 'sinatra'

class RockPaperScissors < Sinatra::Base

enable :sessions

  get '/' do
    erb :homepage
  end

  post '/' do
    session['player_name'] = params[:player_name]
    @player_name = session['player_name']
    erb :menu
  end

  get '/game' do
    # session['results'] = []
    # session ['count'] = 0
    # @rounds = session['rounds'].to_i
    erb :game
  end
end
