require_relative 'parse_h1.rb'
require_relative 'parse_h2.rb'
require_relative 'parse_h3.rb'
require_relative 'parse_bq.rb'
require_relative 'parse_li.rb'
require_relative 'parser.rb'

module ParseLines
  include Parser
  include ParseH1
  include ParseH2
  include ParseH3 
  include ParseBq 
  include ParseLi 
  
  private
  # Checks line format
  def parse_lines input
    if !input.is_a? Array
      input = parse input 
    end
    pairs = Array.new
    input.each do |line|
      pair = Hash.new
      case true  
      when is_h1?(line)
        pair = {"type" => "h1", "string" => parse_h1(line)}
      when is_h2?(line)
        pair = {"type" => "h2", "string" => parse_h2(line)}
      when is_h3?(line)
        pair = {"type" => "h3", "string" => parse_h3(line)}
      when is_bq?(line)
        pair = {"type" => "bq", "string" => parse_bq(line)}
      when is_li?(line)
        pair = {"type" => "li", "string" => parse_li(line)}
      else
        pair = {"type" => "p", "string" => line }
      end
      pairs << pair
    end
    pairs
  end
end
