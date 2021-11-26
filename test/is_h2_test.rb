require_relative '../lib/is_h2.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include IsH2

  def setup
    @@h2_examples = Array.new
# Example 1: I expect this to return true, formatted as heading-2.
ex_1 = Hash.new
ex_1["input"] = <<-STRING
## My level-2 heading
STRING
ex_1["expected"] = true
@@h2_examples << ex_1

# Example 2: I expect this to return false, not formatted as heading-2.
ex_2 = Hash.new
ex_2["input"] = <<-STRING
# Testing (not a level-2 heading)
STRING
ex_2["expected"] = false
@@h2_examples << ex_2

# Example 3: I expect this to return false.
ex_3 = Hash.new
ex_3["input"] = <<-STRING
# Capsule
STRING
ex_3["expected"] = false
@@h2_examples << ex_3

# Example 4: I expect this to return true
ex_4 = Hash.new
ex_4["input"] = <<-STRING
## Not a level-1 heading, it is a level-2 heading!
STRING
ex_4["expected"] = true
@@h2_examples << ex_4

# Example 5: I expect this to return false
ex_5 = Hash.new
ex_5["input"] = <<-STRING
- Not a level-2 heading
STRING
ex_5["expected"] = false
@@h2_examples << ex_5
  end
  
  def test_is_h2?
    @@h2_examples.each do |example|
      is_h2_result = is_h2? example["input"]
      assert_equal example["expected"], is_h2_result
    end
  end
end
