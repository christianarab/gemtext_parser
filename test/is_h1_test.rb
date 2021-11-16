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

# Example 3: I expect ["# Testing", "one,  ", "  three,", ",,,two           "] as an array.
ex_3 = Hash.new
ex_3["input"] = <<-STRING
# New heading
STRING
ex_3["expected"] = true
@@h1_examples << ex_3
  end
  
  def test_is_h1?
    @@h1_examples.each do |example|
      is_h1_result = is_h1? example["input"]
      assert_equal example["expected"], is_h1_result
    end
  end
end
