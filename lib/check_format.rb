require_relative 'is_h1.rb'
require_relative 'is_h2.rb'
require_relative 'is_h3.rb'
require_relative 'is_bq.rb'
require_relative 'is_li.rb'
require_relative 'parser.rb'

module CheckFormat
  include IsH1 
  include IsH2
  include IsH3 
  include IsBq 
  include IsLi 
  include Parser
  
  private
  # Checks line format
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
        pair["type"] = "p"
      end
      pairs << pair
    end
    pairs
  end
end