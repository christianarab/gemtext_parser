require_relative 'type_prefix.rb'

module IsLi
  include PrefixTypes

  private
  # True if input is gemini list-item. Otherwise, false.
  def is_li? input
    input.start_with? PrefixLi
  end
end