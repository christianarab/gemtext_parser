require_relative 'type_prefix.rb'

module RenderHTML

  private 
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
    end
    pairs.each do |pair|
      case true
        when pair["type"] == "h1"
          result << "<h1>#{pair["string"].encode!(:xml => :text)}</h1>"
        when pair["type"] == "h2"
          result << "<h2>#{pair["string"].encode!(:xml => :text)}</h2>"
        when pair["type"] == "h3"
          result << "<h3>#{pair["string"].encode!(:xml => :text)}</h3>"
        when pair["type"] == "li"
          result << "<li>#{pair["string"].encode!(:xml => :text)}</li>"
        when pair["type"] == "bq"
          result << "<blockquote>#{pair["string"].encode!(:xml => :text)}</blockquote>"
        else 
          result << "<p>#{pair["string"].encode!(:xml => :text)}</p>"
        end
      end
    result.join("\n")
  end
end