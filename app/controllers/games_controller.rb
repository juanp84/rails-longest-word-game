require 'json'
require 'open-uri'

class GamesController < ApplicationController
  attr_accessor :sample
  def new
    letters = ('A'..'Z').to_a
    @sample = []
    rand(2..3).times { @sample << %w[A E I O U Y].sample }
    times = rand(5..7)
    times.times do
      @sample << letters.sample
    end
  end

def score
    @word = params[:word].upcase.split('')
    @sample = params[:sample].split
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user_serialized = open(url).read
    @api_result = JSON.parse(user_serialized)
    in_grid = @word.all? { |letter| @word.count(letter) <= @sample.count(letter) }
    if in_grid && @api_result['found']
      @message = 'YOU WIN'
    elsif in_grid
      @message = 'Not an english word'
    elsif @api_result['found']
      @message = 'Not in the grid'
    else
      @message = 'Neither english nor in the grid'
    end
  end
end
