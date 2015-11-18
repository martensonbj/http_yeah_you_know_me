require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './dictionary'
require './request_handler'

class DictionaryTest < Minitest::Test

def test_dictionary_class
  assert Dictionary
end

def test_input_is_a_string
  @path = "/word_search?word=happy"
  d = Dictionary.new(@path)
  assert_equal String, @path.class
end

def test_dictionary_starts_with_empty_array
  d = Dictionary.new("/word_search?word=happy")
  @analyzed_words = []
  assert_equal 0, @analyzed_words.count
end

def test_analyzed_words_array_contains_a_sentence_when_searching_for_a_word
  d = Dictionary.new("/word_search?word=happy")
  @analyzed_words = []
  d.shoveler(["HAPPY is a known word!"])
  assert @analyzed_words.find("HAPPY")
end

def test_dictionary_has_external_dictionary_string_of_words
  d = Dictionary.new("/word_search?word=happy")
  @dictionary = File.read("/usr/share/dict/words")
  assert_equal String, @dictionary.class
end

def test_split_word_search_path_outputs_data
  d = Dictionary.new("/word_search?word=happy")
  refute nil, d.split_word_search_path("/word_search?word=happy")
end


def test_shoveler_creates_new_array_of_two_elements
  d = Dictionary.new("/word_search?word=happy")
  @analyzed_words = []
  d.split_word_search_path("/word_search?word=happy")
  assert_equal 2, d.shoveler(["/word_search?word", "happy"]).count
end

def test_shoveler_creates_array_of_multiple_words
  d= Dictionary.new("/word_search?word=happy&word=sad")
  assert_equal 2, d.shoveler(["/word_search?word", "happy"]).count
end

def word_analyzer_outputs_checked_words
  d = Dictionary.new("/word_search?word=happy")
  assert_equal "HAPPY is a known word!", d.word_analyzer
end

end
