module IsH1
  private 
  # True if input is gemini text level-1-heading. Otherwise, false.
  def is_h1? input
    input.start_with?("# ")
  end
end