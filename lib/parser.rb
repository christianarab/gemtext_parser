module Parser
  private
  # Parses input. Raises error if input is not a string.
  def parse input
    if !input.is_a? String
      raise StandardError.new "Error: Not a string!"
    else
      parsed_output = []
      input.each_line { |ln| parsed_output << ln.chomp }
      parsed_output
    end
  end
end
