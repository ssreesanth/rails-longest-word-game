require 'open-uri'
require 'json'

class GamesController < ApplicationController

def new
  word_array = ('a'..'z').to_a
  @letters = word_array.sample(10)
  session[:letters] = @letters
end

def score
  @letters = session[:letters]
  @word = params[:word]
  @is_valid = valid_word?(@word)
  @included = included?(@word, @letters)
end


def valid_word?(word)
  url = URI.open("https://dictionary.lewagon.com/#{word}")
  json = JSON.parse(url.read)
  json["found"]
end

def included?(word, letters)
  word.chars.all? do |char|
    letters.include?(char.upcase)
  end
end


end
