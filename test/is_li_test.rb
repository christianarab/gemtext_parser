require_relative '../lib/is_li.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include IsLi

  def setup
    @@li_examples = Array.new
# Example 1: I expect this to return true, formatted as a list-item.
ex_1 = Hash.new
ex_1["input"] = <<-STRING
* Am I a list item?
STRING
ex_1["expected"] = true
@@li_examples << ex_1

# Example 2: I expect this to return false, this is not a list-item.
ex_2 = Hash.new
ex_2["input"] = <<-STRING
- Not a list item
* This is a list item
STRING
ex_2["expected"] = false
@@li_examples << ex_2

# Example 3: I expect this to return false.
ex_3 = Hash.new
ex_3["input"] = <<-STRING
# Food items
* Chocolate
* Beer
* Oranges
STRING
ex_3["expected"] = false
@@li_examples << ex_3

# Example 4: I expect this to return true.
ex_4 = Hash.new
ex_4["input"] = <<-STRING
** A list item of a list item??!?
STRING
ex_4["expected"] = true
@@li_examples << ex_4

# Example 5: I expect this to return false.
ex_5 = Hash.new
ex_5["input"] = <<-STRING



* List item
STRING
ex_5["expected"] = false
@@li_examples << ex_5

# Example 6: I expect this to return true.
ex_6 = Hash.new
ex_6["input"] = <<-STRING
* List item



STRING
ex_6["expected"] = true
@@li_examples << ex_6
  end
  
  def test_is_li?
    @@li_examples.each do |example|
      is_li_result = is_li? example["input"]
      assert_equal example["expected"], is_li_result
    end
  end
end
