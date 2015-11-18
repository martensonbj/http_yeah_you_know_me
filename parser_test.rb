require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './parser'

class ParserTest < Minitest::Test

  def setup
    @p = Parser.new(["GET / HTTP/1.1",
 "Host: 127.0.0.1:9292",
 "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:41.0) Gecko/20100101 Firefox/41.0",
 "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
 "Accept-Language: en-US,en;q=0.5",
 "Accept-Encoding: gzip, deflate",
 "DNT: 1",
 "Connection: keep-alive",
 "Cache-Control: max-age=0"])
  end

  def test_can_create_parser
    skip
    pars = Parser.new("string")

    assert pars
  end

  def test_can_access_request_lines
    skip
    pars = Parser.new("string")

    assert pars.request_lines
  end

  def test_can_set_verb
    assert_equal "GET", @p.set_verb
  end

  def test_can_set_path
    assert_equal "/", @p.set_path
  end

  def test_can_set_protocol
    assert_equal "HTTP/1.1", @p.set_protocol
  end

  def test_can_set_host
    assert_equal "Host", @p.set_host
  end

  def test_can_set_address
    assert_equal "127.0.0.1", @p.set_address
  end

  def test_can_set_port
    assert_equal "9292", @p.set_port
  end

  def test_can_set_user_agent_title
    assert_equal "User-Agent", @p.set_user_agent_title
  end

  def test_can_set_user_agent_info
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:41.0) Gecko/20100101 Firefox/41.0", @p.set_user_agent_info
  end

  def test_can_set_accept_title
    assert_equal "Accept", @p.set_accept_title
  end

  def test_can_set_accept_info
    assert_equal "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", @p.set_accept_info
  end

  def test_can_set_accept_language_title
    assert_equal "Accept-Language", @p.set_accept_language_title
  end

  def test_can_set_accept_language_info
    assert_equal "en-US,en;q=0.5", @p.set_accept_language_info
  end

  def test_can_set_accept_encode_title
    assert_equal "Accept-Encoding", @p.set_accept_encoding_title
  end

  def test_can_set_accept_encode_info
    assert_equal "gzip, deflate", @p.set_accept_encoding_info
  end

  def test_can_set_DNT_title
    assert_equal "DNT", @p.set_DNT_title
  end

  def test_can_set_DNT_info
    assert_equal "1", @p.set_DNT_info
  end

  def test_can_set_connection_title
    assert_equal "Connection", @p.set_connection_title
  end

  def test_can_set_connection_info
    assert_equal "keep-alive", @p.set_connection_info
  end

  def test_can_set_cache_control_title
    assert_equal "Cache-Control", @p.set_cache_control_title
  end

  def test_can_set_cache_control_info
    assert_equal "max-age=0", @p.set_cache_control_info
  end

  def test_can_parse_all_info
    @p.parse_all_info
    assert_equal "GET", @p.parse_all["Verb"]
    assert_equal "9292", @p.parse_all["Port"]
  end

end
