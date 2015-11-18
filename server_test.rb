require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './server'

class ServerTest < Minitest::Test

  def test_can_start_server
    s = Server.new

    assert s
  end

  def test_request_counter_starts_at_0
    s = Server.new
    assert_equal 0, @request_counter
  end

end
