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

  get '/menu' do
    erb :menu
  end

  post '/rounds' do
    @player_name = session['player_name']
    session['rounds'] = params[:rounds].to_i
    @rounds = params['rounds']
    erb :menu
  end

  get '/game' do
    @count = session['rounds']
    session['count'] = session['rounds'].to_i
    session['player_name']
    session['result'] = []

    if session['leaderboard']
      session['leaderboard'] = session['leaderboard']
    else
      session['leaderboard'] = Hash.new
    end

      erb :game
  end

  get '/game/throw/:player_choice' do

    options = ['Rock','Paper','Scissors']
    computer_choice = rand(options.length)
    player_choice = params[:player_choice]
    @computer_answer = options[computer_choice]

    session['count'] -= 1
    @count = session['count']
    @rounds = session['rounds'].to_i

    if player_choice == 'Rock' && @computer_answer == 'Scissors'
      session['result'].push('Win')
      ans = ['win']
      @result = 'You win!'

    elsif player_choice == 'Paper' && @computer_answer == 'Rock'
      session['result'].push('Win')
      ans = ['win']
      @result ='You win!'

    elsif player_choice == 'Scissors' && @computer_answer == 'Paper'
      session['result'].push('Win')
      ans = ['win']
      @result = 'You win!'

    elsif @computer_answer == 'Rock' && player_choice == 'Scissors'
      session['result'].push('Lose')
      ans = ['lose']
      @result = 'You lose :('

    elsif @computer_answer == 'Paper' && player_choice == 'Rock'
      session['result'].push('Lose')
      ans = ['lose']
      @result = 'You lose :('

    elsif @computer_answer == 'Scissors' && player_choice == 'Paper'
      session['result'].push('Lose')
      ans = ['lose']
      @result = 'You lose :('

    else
      session['result'].push('Tie')
      ans = ['tie']
      @result = 'Tie!'
    end

      erb :game
  end

  get '/view_results' do
    @win_result = session['result'].count('Win')
    @lose_result = session['result'].count('Lose')
    @tie_result = session['result'].count('Tie')


    erb :view_results
  end

  get '/leaderboard' do
  session['leaderboard'].store(session['player_name'], session['result'])
  @leaderboard = session['leaderboard']

    erb :leaderboard
  end

  get '/new' do
    session.clear
    redirect '/'

    erb :new
  end

end
