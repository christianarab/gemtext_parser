require_relative 'parser.rb'

module Start
  include Parser
  private
  # Starts parser.
  def start input
    input.to_s
    parse input
  end
end