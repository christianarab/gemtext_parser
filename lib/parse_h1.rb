require_relative 'is_h1.rb'

module ParseH1
  include IsH1

  private 
  # Parses level-1-heading. If input starts with "# ", return string without type prefix. Else, input.
  def parse_h1 input
    is_h1?(input) ? input[PrefixH1.length..-2] : input.chomp
  end
end