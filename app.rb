module Gemtext
  module Parser
    # Parses input. Raises error if input is not a string.
    def parse input
      if input.length < 0 or !input.is_a? String
        raise StandardError.new "Error: Not a string!"
      else
        parsed_output = []
        input.each_line do |ln|
          pair = Hash.new
          pair["input"] = ln.chomp
          pair["type"] = check_format ln
          parsed_output << pair
        end
        parsed_output
      end
    end

    def check_format input
      case true  
        when is_h1?(input)
          "h1"
        when is_h2?(input)
          "h2"
        when is_h3?(input)
          "h3"
        when is_bq?(input)
          "bq"
        when is_li?(input)
          "li"
        else
          "uf"
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

    # True if input is gemini text blockquote. Otherwise, false.
    def is_bq? input
      if input.start_with? ">"
        true
      else
        false
      end
    end

    # True if input is gemini list-item. Otherwise, false.
    def is_li? input
      if input.start_with? "*"
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
