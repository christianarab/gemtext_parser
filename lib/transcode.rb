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
    lines = gemtext_lines input 
    pair = parse_lines lines
    case output_type
    when 'terminal'
      render_terminal pairs
    when 'html'
      render_html pairs
    else
      StandardError.new "Incorrect output type. Must be 'terminal', or 'html'."
    end
  end
end