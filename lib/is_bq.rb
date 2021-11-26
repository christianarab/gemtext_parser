module IsBq
  private
  # True if input is gemini text blockquote. Otherwise, false.
  def is_bq? input
    if input.start_with? ">"
      true
    else
      false
    end
  end
end