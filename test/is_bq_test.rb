require_relative '../is_bq.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include IsBq

  def setup
    @@bq_examples = Array.new
# Example 1: I expect this to return true, formatted as a blockquote
ex_1 = Hash.new
ex_1["input"] = <<-STRING
> Here's a quote. But what if I add more > or # or ###?
STRING
ex_1["expected"] = true
@@bq_examples << ex_1

# Example 2: I expect this to return false, this is not a blockquote.
ex_2 = Hash.new
ex_2["input"] = <<-STRING
* Apples
* Oranges
* Blockquotes
STRING
ex_2["expected"] = false
@@bq_examples << ex_2

# Example 3: I expect this to return false.
ex_3 = Hash.new
ex_3["input"] = <<-STRING
# My header
> This is the blockquote under the header
STRING
ex_3["expected"] = false
@@bq_examples << ex_3

# Example 4: I expect this to return true.
ex_4 = Hash.new
ex_4["input"] = <<-STRING
># Capsule
STRING
ex_4["expected"] = false
@@bq_examples << ex_4

# Example 5: I expect this to return false.
ex_5 = Hash.new
ex_5["input"] = <<-STRING



> Space is the place.
STRING
ex_5["expected"] = false
@@bq_examples << ex_5
  end
  
  def test_is_bq?
    @@bq_examples.each do |example|
      is_bq_result = is_bq? example["input"]
      assert_equal example["expected"], is_bq_result
    end
  end
end
