require_relative 'is_li.rb'

module ParseLi
  include IsLi

  private 
  # Parses list item. If input starts with "* ", return string without type prefix. Else, raise error.
  def parse_li input
    is_li?(input) ? input[PrefixLi.length..-1] : (raise StandardError.new "Input not formatted as a list item.")
  end
end