class Dictionary

  attr_accessor :output, :string

  def initialize(string)
    @string = string
    @dictionary = File.read("/usr/share/dict/words")
    @analyzed_words = []
    word_analyzer
  end

  def split_word_search_path(string)
    split_path_once = string.split("&")

    split_path_twice = split_path_once.map do |element|
      element.split("=")
    end
    split_path_twice
  end

  def shoveler(array)
    array.each do |element|
      if @dictionary.include?(element[1])
        @analyzed_words << "#{element[1].upcase} is a known word!"
      else
        @analyzed_words << "#{element[1].upcase} is not a known word!"
      end
    end
  end

  def word_analyzer
    data = split_word_search_path(@string)
    shoveler(data)
    formatted_analyzed_words = @analyzed_words.each do |element|
      puts "#{element}\n"
    end
    @output = "<html><head></head><body><pre>#{formatted_analyzed_words.join("\n")}</pre></body></html>"
  end

end
