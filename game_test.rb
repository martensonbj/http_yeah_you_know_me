require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './game'

class GameTest < Minitest::Test

  def test_game_class
    assert Game
  end

  def test_game_class_initializes_with_parser
    g = Game.new('"Verb"=>"POST", "Path"=>"/start_game", "Guess Number"', 0, 0)
    refute nil, g.parser
  end

  def test_path_is_slash_start_game
    skip
    g = Game.new("/start_game")

    assert_equal "/start_game", g.path
  end

  def test_starts_game_when_first_posted_to
    skip
    g = Game.new("path", 0, 0)

    assert_equal "Good luck!", g.game_output
    assert_equal 0, g.guess_counter
    refute_equal 101, g.secret_number
  end

end
