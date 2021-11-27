require_relative 'type_prefix.rb'

module IsBq
  include PrefixTypes
  
  private
  # True if input is gemini text blockquote. Otherwise, false.
  def is_bq? input
    input.start_with? PrefixBq
  end
end