module IsH2
  private 
  # True if input is gemini text level-2-heading. Otherwise, false.
  def is_h2? input
    input.start_with?("## ")
  end
end