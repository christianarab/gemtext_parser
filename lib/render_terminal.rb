require_relative 'type_values.rb'
require 'erb'

module RenderTerminal
  include TypeValues
  
  private 

  def text_color color
    case color
    when "red"
      "\u001b[31m"
    when "green"
      "\u001b[32m"
    when "blue"
      "\u001b[34m"
    else
      nil
    end
  end

  def render_terminal pairs
    result = []

    if !pairs.is_a? Array
      raise StandardError.new("Input must be an array.")
    end

    pairs.each do |pair|
      if !pair.key?("type") 
        raise StandardError.new("Pairs must have a key of: type")
      end

      if !pair.key?("string") 
        raise StandardError.new("Pairs must have a key of: string")
      end

      if pair.key?("color")
        color = text_color pair["color"]
        if color then pair["string"].prepend(color) else nil end
      end

      case pair["type"]
        when TypeBq
          result << "“#{pair["string"]}”"
        when TypeH1
          result << "\u001b[41m\033[1m\u001b[30m#{pair["string"]}\u001b[0m"
        when TypeH2
          result << "\u001b[31m\033[1m#{pair["string"]}\u001b[0m"
        when TypeH3
          result << "\033[1m#{pair["string"]}\033[1m\u001b[0m"
        when TypeLi
          result << "• #{pair["string"]}"
        when TypeP
          result << "#{pair["string"]}"
        when TypeLink
          result << "\x1b[48;2;255;199;9m\u001b[30m⇒ #{pair["url"]} #{pair["string"]}\u001b[0m"
        else
          raise StandardError.new("Type value error.")
      end
    end
    result
  end
end
