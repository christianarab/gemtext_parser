require_relative 'is_h3.rb'

module ParseH3
  include IsH3

  private
  # Parses level-3-heading. If input starts with "### ", return string without type prefix. Else, input.
  def parse_h3 input
    is_h3?(input) ? input[PrefixH3.length..-2] : input.chomp
  end
end