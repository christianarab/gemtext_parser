require_relative 'render_html'
require_relative 'render_terminal'
require_relative 'parse_lines'
require_relative 'gemtext_lines'

module Transcode
  include RenderTerminal
  include RenderHTML
  include ParseLines
  include GemtextLines

  private

  def transcode(input, output_type)
    input = gemtext_lines input 
    lines = parse_lines input
    case output_type
    when 'terminal'
      render_terminal lines
    when 'html'
      render_html lines
    else
      StandardError.new "Incorrect output type. Must be 'terminal', or 'html'."
    end
  end
end