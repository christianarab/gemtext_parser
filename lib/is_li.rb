module IsLi
  private
  # True if input is gemini list-item. Otherwise, false.
  def is_li? input
    if input.start_with? "*"
      true
    else
      false
    end
  end
end