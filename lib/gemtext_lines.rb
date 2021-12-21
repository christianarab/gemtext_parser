require_relative 'type_delimiters.rb'

module GemtextLines
  include DelimiterTypes

  private

  def gemtext_lines string
    if !string.is_a? String
      raise StandardError.new "Error: Not a string!"
    else
      arr = []
      string.each_char do |char| 
        case char
        when DelimitLineFeed, 
             DelimitLineCarriage, 
             DelimitNextLine
          break
        else
          arr << char
        end
      end
      arr.join.chomp # returns string
    end
  end
end
