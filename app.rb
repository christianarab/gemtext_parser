module Gemtext
  module Parser
    # Gemini links
    # ["=> "]

    # Gemini headings
    # ["# ", "## ", "### "]

    # Gemini list
    # ["* "]

    # Gemini quote
    # ["> "]

    # Gemini pre-formatted text
    # ["```", "```"]

    # Parses input. Raises error if input is not a string.
    def parse input
      if input.length < 0 or !input.is_a? String
        raise StandardError.new "Error: Not a string!"
      else
        parsed_output = []
        input.each_line { |ln| parsed_output << ln.chomp }
        parsed_output
      end
    end
    
    # True if input is gemini text level-1-heading. Otherwise, false.
    def is_h1? input
      if input.start_with? "# "
        true
      else
        false
      end
    end

    # True if input is gemini text level-2-heading. Otherwise, false.
    def is_h2? input
      if input.start_with? "## "
        true
      else
        false
      end
    end
    
    # True if input is gemini text level-3-heading. Otherwise, false.
    def is_h3? input
      if input.start_with? "### "
        true
      else
        false
      end
    end

    # Starts parser.
    def start input
      input.to_s
      parse input
    end
  end
end
