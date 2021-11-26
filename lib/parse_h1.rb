module ParseH1
  private 
    # Parses level-1-heading. If input starts with "# ", return string without type prefix. Else, input.
    def parse_h1 input
      (input.start_with?("# ") == true) ? input.split("# ", 2).last.chomp : input.chomp
    end
end