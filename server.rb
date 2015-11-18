require 'socket'
require 'pry'
require './parser'
require './request_handler'

class Server

  attr_accessor :request_counter, :guess_counter, :secret_number, :server_guesses

  tcp_server = TCPServer.new(9292)
  @request_counter = 0
  @guess_counter = 0
  @server_guesses = []
  @secret_number = 0
  client = tcp_server.accept

  loop do

    puts "Ready for a request"

    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end

    if request_lines.join.include?("Content-Type")
      while line = client.gets and !line.chomp.empty?
        request_lines << line .chomp
      end
      request_lines << client.gets
    end

    @request_counter += 1

    parser = Parser.new(request_lines)
    if parser.array[0].include?("---")
      g = Game.new(parser, @secret_number, @server_guesses)
      @guess_counter += 1
      if g.guesses[-1] != nil
        @server_guesses << g.guesses[-1]
      end
    elsif parser.parse_all["Path"] == "/game"
      g = Game.new(parser, @secret_number, @server_guesses)
      @guess_counter += 1
      if g.guesses[-1] != nil
        @server_guesses << g.guesses[-1]
      end
    elsif parser.parse_all["Path"] == "/start_game"
      g = Game.new(parser, @secret_number, @server_guesses)
      @secret_number = g.secret_number
    else
      rh = RequestHandler.new(parser, @request_counter)
    end

    puts "Got this request:"
    puts request_lines.inspect

    puts "Sending response."

    content_output = ""

    if parser.parse_all["Verb"] == "GET" && parser.parse_all["Path"] == "/game"
      content_output = g.game_output
    elsif parser.parse_all["Verb"] == "GET"
      content_output = rh.output
    else
      content_output = g.game_output
    end

    headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{content_output.length}\r\n\r\n"].join("\r\n")
    headers_two = ["http/1.1 302 Found",
                    "Location: http://127.0.0.1:9292/game",
                    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                    "server: ruby",
                    "content-type: text/html; charset=iso-8859-1",
                    "content-length: #{content_output.length}\r\n\r\n"].join("\r\n")

    if parser.parse_all["Path"] == "/game" && parser.parse_all["Verb"] == "POST"
      client.puts headers_two
      puts ["Wrote this response:", headers_two, content_output].join("\n")
    else
      client.puts headers
      puts ["Wrote this response:", headers, content_output].join("\n")
    end
    client.puts content_output

    if parser.parse_all["Path"] == "/shutdown"
      break
    end
  end

  client.close
  puts "\nResponse complete, exiting."

end
