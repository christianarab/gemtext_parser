require_relative 'type_prefix.rb'

module IsLink
  include PrefixTypes
  
  private
  # True if input is formatted as a link. Otherwise, false.
  def is_link? input
    input.start_with? PrefixLink
  end
end