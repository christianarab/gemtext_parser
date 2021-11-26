require_relative '../lib/parse_h2.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include ParseH2

  def setup
    @@h2_examples = Array.new

# Example 1
ex_1 = Hash.new
ex_1["input"] = <<-STRING
## My level-2 heading
STRING
ex_1["expected"] = "My level-2 heading"
@@h2_examples << ex_1

# Example 2
ex_2 = Hash.new
ex_2["input"] = <<-STRING
For H2: ## H2
STRING
ex_2["expected"] = "For H2: ## H2"
@@h2_examples << ex_2

# Example 3
ex_3 = Hash.new
ex_3["input"] = <<-STRING
# H1 heading
STRING
ex_3["expected"] = "# H1 heading"
@@h2_examples << ex_3

# Example 4
ex_4 = Hash.new
ex_4["input"] = <<-STRING
## Not a level-1 heading
STRING
ex_4["expected"] = "Not a level-1 heading"
@@h2_examples << ex_4

# Example 5
ex_5 = Hash.new
ex_5["input"] = <<-STRING
What happens ## with This?
STRING
ex_5["expected"] = "What happens ## with This?"
@@h2_examples << ex_5

# Example 6
ex_6 = Hash.new
ex_6["input"] = <<-STRING
## H2     #######
STRING
ex_6["expected"] = "H2     #######"
@@h2_examples << ex_6
  end
  
  def test_parse_h2
    @@h2_examples.each do |example|
      h2_result = parse_h2 example["input"]
      assert_equal example["expected"], h2_result
    end
  end
end
