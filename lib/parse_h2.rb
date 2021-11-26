module ParseH2
  private 
    # Parses level-2-heading. If input starts with "## ", return string without type prefix. Else, input.
    def parse_h2 input
      input[0..2] === "## " ? input[3..-2] : input.chomp
    end
end