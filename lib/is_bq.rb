module IsBq
  private
  # True if input is gemini text blockquote. Otherwise, false.
  def is_bq? input
    input.start_with?("> ") ? true : false
  end
end