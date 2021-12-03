require_relative 'parse_lines.rb'

module RenderHTML
  include ParseLines

  private 
  # Renders parsed_lines output as HTML formatted strings.
  def render_html input
    html_strings = parse_lines input
    html_strings.each do |string|
      return "<#{string["type"]}>#{string["string"]}</#{string["type"]}>"
    end
  end
end
