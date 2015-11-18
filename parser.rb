class Parser

  attr_accessor :parse_all, :array

  def initialize(array)
    @array = array
    @parse_all = {}
    if @array[0].include?("---")
      @array.shift
    end
    parse_all_info
  end

  def split_element_colon(index, position)
    split_element = @array[index].split(':')
    split_element[position]
  end

  def split_element_space(index, position)
    split_element = @array[index].split(' ')
    split_element[position]
  end

  def split_element_space_shift(index)
    split_element = @array[index].split(' ')
    split_element.shift
    split_element.join(' ')
  end

  def set_verb
    split_element = @array[0].split(' ')
    split_element[0]
  end

  def set_path
    split_element_space(0, 1)
  end

  def set_protocol
    split_element_space(0, 2)
  end

  def set_host
    split_element_colon(1, 0)
  end

  def set_address
    address = split_element_colon(1, 1)
    address.strip
  end

  def set_port
    split_element_colon(1, 2)
  end

  def set_user_agent_title
    split_element_colon(2, 0)
  end

  def set_user_agent_info
    split_element_space_shift(2)
  end

  def set_accept_title
    split_element_colon(3, 0)
  end

  def set_accept_info
    split_element_space(3, 1)
  end

  def set_accept_language_title
    split_element_colon(4, 0)
  end

  def set_accept_language_info
    split_element_space(4, 1)
  end

  def set_accept_encoding_title
    split_element_colon(5, 0)
  end

  def set_accept_encoding_info
    split_element_space_shift(5)
  end

  def set_DNT_title
    split_element_colon(6, 0)
  end

  def set_DNT_info
    split_element_space(6, 1)
  end

  def set_connection_title
    split_element_colon(7, 0)
  end

  def set_connection_info
    split_element_space(7, 1)
  end

  def set_cache_control_title
    if @array[8].nil?
    else
      split_element_colon(8, 0)
    end
  end

  def set_cache_control_info
    if @array[8].nil?
    else
      split_element_space(8, 1)
    end
  end

  def set_guess_number
    @array.last.to_i
  end

  def parse_all_info
    if @array[0].include?("GET")
      parse_get
    else
      parse_post
    end
  end

  def parse_post
    @array[0].include?("POST")
    puts "POST Found!"
    @parse_all["Verb"] = set_verb
    @parse_all["Path"] = set_path
    @parse_all["Guess Number"] = set_guess_number
  end

  def parse_get
    @parse_all["Verb"] = set_verb
    @parse_all["Path"] = set_path
    @parse_all["Protocol"] = set_protocol
    @parse_all[set_host] = set_address
    @parse_all["Port"] = set_port
    @parse_all[set_user_agent_title] = set_user_agent_info
    @parse_all[set_accept_title] = set_accept_info
    @parse_all[set_accept_language_title] = set_accept_language_info
    @parse_all[set_accept_encoding_title] = set_accept_encoding_info
    @parse_all[set_DNT_title] = set_DNT_info
    @parse_all[set_connection_title] = set_connection_info
    @parse_all[set_cache_control_title] = set_cache_control_info
    @parse_all
  end

end
