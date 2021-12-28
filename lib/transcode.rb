require_relative 'render_html'
require_relative 'render_terminal'
require_relative 'parse_lines'

module Transcode
  include RenderTerminal
  include RenderHTML
  include ParseLines

  private

  def transcode(input = [], output_type)
    line = parse_lines input 
    case output_type
    when 'terminal'
      render_terminal line
    when 'html'
      render_html line
    else
      StandardError.new "Incorrect output type. Must be 'terminal', or 'html'."
    end
  end
end