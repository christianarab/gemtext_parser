require_relative 'is_bq.rb'

module ParseBq
  include IsBq

  private 
  # Parses blockquote. If input starts with "> ", return string without type prefix. Else, raise error.
  def parse_bq input
    is_bq?(input) ? input[PrefixBq.length..-1] : (raise StandardError.new "Input not formatted as a blockquote.")
  end
end