module IsH3
  private 
  # True if input is gemini text level-3-heading. Otherwise, false.
  def is_h3? input
    input.start_with?("### ") ? true : false
  end
end