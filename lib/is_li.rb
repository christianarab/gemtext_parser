module IsLi
  private
  # True if input is gemini list-item. Otherwise, false.
  def is_li? input
    input.start_with?("* ")
  end
end