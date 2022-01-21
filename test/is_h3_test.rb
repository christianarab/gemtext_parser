require_relative '../is_h3.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include IsH3
  
  def setup
    @@h3_examples = Array.new
# Example 1: I expect this to return true, formatted as heading-3.
ex_1 = Hash.new
ex_1["input"] = <<-STRING
### A level 3 heading!
STRING
ex_1["expected"] = true
@@h3_examples << ex_1

# Example 2: I expect this to return false, not formatted as a list item
ex_2 = Hash.new
ex_2["input"] = <<-STRING
* My list item
### New heading
STRING
ex_2["expected"] = false
@@h3_examples << ex_2

# Example 3: I expect this to return false.
ex_3 = Hash.new
ex_3["input"] = <<-STRING
# Level one
STRING
ex_3["expected"] = false
@@h3_examples << ex_3

# Example 4: I expect this to return true
ex_4 = Hash.new
ex_4["input"] = <<-STRING
### War and Peace
STRING
ex_4["expected"] = true
@@h3_examples << ex_4

# Example 5: I expect this to return false
ex_5 = Hash.new
ex_5["input"] = <<-STRING
To make level-3 headings use "### "
STRING
ex_5["expected"] = false
@@h3_examples << ex_5
  end
  
  def test_is_h3?
    @@h3_examples.each do |example|
      is_h3_result = is_h3? example["input"]
      assert_equal example["expected"], is_h3_result
    end
  end
end
