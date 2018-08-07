require 'rest-client'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { Array('A'..'Z').sample}
  end

  def score
    @word = params[:word].downcase
    @word_single = @word.split("")
    # ["h", "e", "l", "l", "o"]

    @letters = params[:letters].downcase
    @letters_single = @letters.split(" ")
    # @letters = @letters.split("")
    # "letters"=>"S L Z X C Y B E C J", "word"=>"hey"}


    @word_single.each do |letter|
      if !@letters_single.include?(letter)
         return @answer = "Sorry but #{@word} can´t be build out of #{@letters}"
       end
     end

    @test = test_if_english(@word)
    if !@test
      return @answer = "Sorry but #{@word} does not seem to be a valid english word!"
    end

    return @answer = "Aweseome"

  end

  private

  def test_if_english(word)
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response = RestClient.get(url)
    @json = JSON.parse(response)
    return @json["found"] == true
  end

end





# The word can't be built out of the original grid
# The word is valid according to the grid, but is not a valid English word
# The word is valid according to the grid and is an English word

