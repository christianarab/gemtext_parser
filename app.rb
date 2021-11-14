module Gemtext
  module Parser
    def self.parse input
      parsed_output = []
      input.each_line { |ln| parsed_output << ln.chomp }
      parsed_output
    end

    def self.start input
      parse input
    end
  end
end