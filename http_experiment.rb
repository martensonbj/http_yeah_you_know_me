require 'socket'
require 'pry'
require './parser'

class Server

  tcp_server = TCPServer.new(9292)
  request_counter = 0
  client = tcp_server.accept

  loop do

    puts "Ready for a request"
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    parser = Parser.new(request_lines)
    request_counter += 1
    output_hash = parser.parse_all

    puts "Got this request:"
    puts request_lines.inspect

    puts "Sending response."
    response_2 = "<p>Hello, World! (#{request_counter})</p>"
    storage = []
    output_hash.each_pair do |key, value|
      storage << "#{key}: #{value}"
    end
    formatted_storage = "<pre>" + storage.join("\n") + "</pre>"

    output = "<html><head></head><body>#{response_2}#{formatted_storage}</body></html>"
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output

    puts ["Wrote this response:", headers, output].join("\n")

  end

  client.close
  puts "\nResponse complete, exiting."

end
