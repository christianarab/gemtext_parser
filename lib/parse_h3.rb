module ParseH3
  private 
    # Parses level-3-heading. If input starts with "### ", return string without type prefix. Else, input.
    def parse_h3 input
      input[0..3] === "### " ? input[4..-2] : input.chomp
    end
end