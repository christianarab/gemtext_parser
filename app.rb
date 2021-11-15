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

    def self.parse line
      if line.length < 0 or !line.is_a? String
        raise StandardError.new "Error: Not a string!"
      else
        check_heading line
        parsed_output = []
        line.each_line { |ln| parsed_output << ln.chomp }
        parsed_output
      end
    end

    def self.start input
      input.to_s
      parse input
    end

    def self.check_heading line
      puts "... Checking line(s) formatting ..."
      if line.start_with? "# "
        puts "Line(s) parsed: #{line}"
        puts "True: Is formatted as a Gemtext level-1-heading."
        true
      else
        puts "Line(s) parsed: #{line}"
        puts "False: Is not formatted Gemtext level-1-heading."
        false
      end
    end
  end
end