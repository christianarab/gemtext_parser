module IsH2
  private 
  # True if input is gemini text level-2-heading. Otherwise, false.
  def is_h2? input
    if input.start_with? "## "
      true
    else
      false
    end
  end
end