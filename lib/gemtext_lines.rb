module GemtextLines
  private

  def gemtext_lines string
    if !string.is_a? String
      raise StandardError.new "Error: Not a string!"
    else
      string.split(/(\n)/).each_slice(2).map { |e| e.join.chomp }
    end
  end
end