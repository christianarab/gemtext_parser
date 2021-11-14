
file = File.open './text.gmi'

module Gemtext
  module Parser
    def self.parse(file)
      parsed = []
      file.each_line { |ln| parsed << ln.chomp }
      puts parsed.inspect
    end

    def self.start(file)
      if file.is_a? File then parse(file)
      else raise Error
      end
    end
  end
end

Gemtext::Parser.start(file)