require '../app.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include Gemtext::Parser

  def setup
    @@h1_examples = Array.new
# Example 1: I expect this to return true, formatted as heading-1.
ex_1 = Hash.new
ex_1["input"] = <<-STRING
# My heading  
STRING
ex_1["expected"] = true
@@h1_examples << ex_1

# Example 2: I expect this to return false, not formatted as heading-1.
ex_2 = Hash.new
ex_2["input"] = <<-STRING
## Testing
STRING
ex_2["expected"] = false
@@h1_examples << ex_2

# Example 3: I expect this to return true.
ex_3 = Hash.new
ex_3["input"] = <<-STRING
# New heading
STRING
ex_3["expected"] = true
@@h1_examples << ex_3

# Example 4: I expect this to return false
ex_4 = Hash.new
ex_4["input"] = <<-STRING
## Not a level-1 heading
STRING
ex_4["expected"] = false
@@h1_examples << ex_4

# Example 5: I expect this to return false
ex_5 = Hash.new
ex_5["input"] = <<-STRING
## Not a level-1 heading
STRING
ex_5["expected"] = false
@@h1_examples << ex_5

# Example 6: I expect this to return false
ex_6 = Hash.new
ex_6["input"] = <<-STRING



# A level-1 heading???
STRING
ex_6["expected"] = false
@@h1_examples << ex_6

# Example 7: I expect this to return true.
ex_7 = Hash.new
ex_7["input"] = <<-STRING
# A level-1 heading???
## What will this do, when I add this here?
STRING
ex_7["expected"] = true
@@h1_examples << ex_7

# Example 8: I expect this to return false
ex_8 = Hash.new
ex_8["input"] = <<-STRING
## A level-2 heading to begin
# Then a level-1?
# What will happen?
STRING
ex_8["expected"] = false
@@h1_examples << ex_8

  end
  
  def test_is_h1?
    @@h1_examples.each do |example|
      is_h1_result = is_h1? example["input"]
      assert_equal example["expected"], is_h1_result
    end
  end
end
