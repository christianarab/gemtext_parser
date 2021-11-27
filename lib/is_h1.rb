require_relative 'type_prefix.rb'

module IsH1
  include PrefixTypes

  private 
  # True if input is gemini text level-1-heading. Otherwise, false.
  def is_h1? input
    input.start_with? PrefixH1
  end
end