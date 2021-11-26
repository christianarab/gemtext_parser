module ParseH2
  private 
    # Parses level-2-heading. If input starts with "## ", return string without type prefix. Else, input.
    def parse_h2 input
      (input.start_with?("## ") == true) ? input.split("## ", 2).last.chomp : input.chomp
    end
end