module Gemtext
  module Parser
    # Parses input. Raises error if input is not a string.
    def parse input
      if !input.is_a? String
        raise StandardError.new "Error: Not a string!"
      else
        parsed_output = []
        input.each_line { |ln| parsed_output << ln.chomp }
        parsed_output
      end
    end

    def check_format input
      if !input.is_a? Array
        input = parse input 
      end
      pairs = Array.new
      input.each do |line|
        pair = Hash.new
        pair["string"] = line
        case true  
        when is_h1?(line)
          pair["type"] = "h1"
        when is_h2?(line)
          pair["type"] = "h2"
        when is_h3?(line)
          pair["type"] = "h3"
        when is_bq?(line)
          pair["type"] = "bq"
        when is_li?(line)
          pair["type"] = "li"
        else
          pair["type"] = "uf"
        end
        pairs << pair
      end
        pairs
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
