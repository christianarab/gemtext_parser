require_relative 'is_link.rb'

module ParseLink
  include IsLink

  private

  def parse_link input
    result = Array.new
    output = Hash.new
    
    if is_link? input
      temp = input[PrefixLink.length..-1]
      output["url"] = temp.split(" ")[0]
      output["string"] = temp.split(" ")[1..-1].join(" ")
      result << output
    else
      raise StandardError.new "Input not formatted as a link."
    end
    result
  end
end
