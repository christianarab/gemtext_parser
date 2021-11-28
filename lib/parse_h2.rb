require_relative 'is_h2.rb'

module ParseH2
  include IsH2

  private 
  # Parses level-2-heading. If input starts with "## ", return string without type prefix. Else, input.
  def parse_h2 input
    is_h2?(input) ? input[PrefixH2.length..-2] : input.chomp
  end
end