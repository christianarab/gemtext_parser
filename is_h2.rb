require_relative 'type_prefix.rb'

module IsH2
  include PrefixTypes

  private 
  # True if input is gemini text level-2-heading. Otherwise, false.
  def is_h2? input
    input.start_with? PrefixH2
  end
end