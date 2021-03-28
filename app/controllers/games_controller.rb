class GamesController < ApplicationController
  def new
    i = 0
    @letters = []
    while i < 9
      @letters << Array('A'..'Z').sample
      i += 1
    end
  end

  def score
    response = RestClient.get("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    answer = JSON.parse(response.body)
    letters = params[:letters].split(' ')
    if params[:word].chars.all? { |letter| params[:words].count(letter) <= letters.count(letter) }
      if answer['found'] == true
        @final_score = [answer['length'], 'Well done!']
      else
        @final_score = [0, 'Damn, you suck!']
      end
    else
      @final_score = [0, 'Damn, that word is not even in the grid man!']
    end
  end
end
