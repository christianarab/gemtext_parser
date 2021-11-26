module ParseH1
  private 
    # Parses level-1-heading. If input starts with "# ", return string without type prefix. Else, input.
    def parse_h1 input
      input[0..1] === "# " ? input[2..-2] : input.chomp
    end
end