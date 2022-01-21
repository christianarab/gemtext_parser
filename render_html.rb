require_relative 'type_values.rb'
require 'erb'

module RenderHTML
  include TypeValues
  
  private 

  HTML_TEMPLATE = ERB.new "<!DOCTYPE html>\n<html>\n<head></head>\n<body>\n<%= yield %>\n</body>\n</html>"

  def get_binding
    binding
  end

  def render
    HTML_TEMPLATE.result get_binding { yield } 
  end
  # Expects an array of a pair with "type" & "string". Outputs a string of HTML formatted strings.
  def render_html pairs
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

      case pair["type"]
        when TypeBq
          result << "<blockquote>#{pair["string"].encode!(:xml => :text)}</blockquote>"
        when TypeH1
          result << "<h1>#{pair["string"].encode!(:xml => :text)}</h1>"
        when TypeH2
          result << "<h2>#{pair["string"].encode!(:xml => :text)}</h2>"
        when TypeH3
          result << "<h3>#{pair["string"].encode!(:xml => :text)}</h3>"
        when TypeLi
          result << "<li>#{pair["string"].encode!(:xml => :text)}</li>"
        when TypeP
          result << "<p>#{pair["string"].encode!(:xml => :text)}</p>"
        when TypeLink
          result << "<div><a href='#{pair["url"].encode!(:xml => :text)}'>#{pair["string"].encode!(:xml => :text)}</a></div>"
        else
          raise StandardError.new("Type value error.")
      end
    end
    renderedHTML = render {result.join("\n")}
  end
end
