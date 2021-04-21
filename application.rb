require 'sinatra'

class RockPaperScissors < Sinatra::Base

  enable :sessions

  get '/' do
    erb :homepage
  end

  post '/' do
    session['player_name'] = params[:player_name]
    @player_name = session['player_name']
    erb :rounds
  end

  get '/game' do
    erb :game
  end

  post '/rounds' do
    session['rounds'] = params[:rounds]
    @rounds = params['rounds']
    erb :menu
  end

  get '/game/throw/:player_choice' do
    session['count'] = 0
    options = ['Rock','Paper','Scissors']
    computer_choice = rand(options.length)
    player_choice = params[:player_choice]
    @computer_answer = options[computer_choice]
    session['count'] += 1

    @count = session['count']
    @rounds = session['rounds'].to_i

    if player_choice == 'Rock' && @computer_answer == 'Scissors'
      @result = 'You win!'
    elsif player_choice == 'Paper' && @computer_answer == 'Rock'
      @result ='You win!'
    elsif player_choice == 'Scissors' && @computer_answer == 'Paper'
      @result = 'You win!'
    elsif @computer_answer == 'Rock' && player_choice == 'Scissors'
      @result = 'You lose :('
    elsif @computer_answer == 'Paper' && player_choice == 'Rock'
      @result = 'You lose :('
    elsif @computer_answer == 'Scissors' && player_choice == 'Paper'
      @result = 'You lose :('
    else
      @result = 'Tie!'
    end
      erb :game
  end
end
