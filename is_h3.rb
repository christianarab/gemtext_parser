require_relative 'type_prefix.rb'

module IsH3
  include PrefixTypes

  private 
  # True if input is gemini text level-3-heading. Otherwise, false.
  def is_h3? input
    input.start_with? PrefixH3
  end
end