module IsH3
  private 
  # True if input is gemini text level-3-heading. Otherwise, false.
  def is_h3? input
    if input.start_with? "### "
      true
    else
      false
    end
  end
end