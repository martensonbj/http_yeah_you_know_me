class Game

  attr_accessor :secret_number, :path, :game_output, :guesses

  def initialize(parser, secret_number, guesses)
    @parser = parser
    @path = parser.parse_all["Path"]
    @secret_number = secret_number
    @guesses = guesses
    if @path == "/start_game"
      start_game
    elsif @path == "/game" && @parser.parse_all["Verb"] == "GET"
      redirected_message
    elsif @path == "/game" && @parser.parse_all["Verb"] == "POST"
      make_guess
    end
  end

  def redirected_message
    if @guesses[-1] == @secret_number
      @game_output = "You chose #{@secret_number}"
    elsif @guesses[-1] > @secret_number
      @game_output = "You chose #{@guesses.last}, your guess is too high."
    else
      @game_output = "You chose #{@guesses.last}, your guess is too low."
    end
  end

  def start_game
    @game_output = "<html><head></head><body><pre>Good luck!</pre></body></html>"
    @secret_number = rand(100)
  end

  def guess_status
    @game_output = "<html><head></head><body><pre>#{@guesses.length} guesses made, last guess:#{@guesses.last}</pre></body></html>"
  end

  def make_guess
    if @parser.parse_all["Guess Number"] == @secret_number
      winner_output = "Correct!"
      @game_output = "<html><head></head><body><pre>#{winner_output}</html>"
    else
      @guesses << @parser.parse_all["Guess Number"]
      if @parser.parse_all["Guess Number"] > @secret_number
        @game_output = "<html><head></head><body><pre>You guessed too high.</pre></body></html>"
      elsif @parser.parse_all["Guess Number"] < @secret_number
        @game_output = "<html><head></head><body><pre>You guessed too low.</pre></body></html>"
      end
    end
  end












end
