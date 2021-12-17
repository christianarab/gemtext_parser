module Parser

  private
  # Parses input. Raises error if input is not a string.
  def parse input
    if !input.is_a? String
      raise StandardError.new "Error: Not a string!"
    else
      gemtext_lines input
    end
  end
end