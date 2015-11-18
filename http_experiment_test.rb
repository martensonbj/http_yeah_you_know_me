require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './http_experiment'

class ServerTest < Minitest::Test

  def test_can_start_server
    s = Server.new

    assert s
  end

  def test_counter_counts
  end

  def test_it
  end




end
