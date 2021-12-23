require_relative 'type_delimiters.rb'

module GemtextLines
  include DelimiterTypes

  private

  def gemtext_lines string
    if !string.is_a? String
      raise StandardError.new "Error: Not a string!"
    else
      lines, line = [], []
      string.each_char do |char| 
        case char
        when DelimitLineFeed, DelimitLineCarriage, DelimitNextLine
          lines << line.join
          line = []
          next
        else
          line << char
        end
      end
      lines << line.join
    end
    lines
  end
end
