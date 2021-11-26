require_relative '../lib/parse_h3.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include ParseH3

  def setup
    @@h3_examples = Array.new
# Example 1
ex_1 = Hash.new
ex_1["input"] = <<-STRING
### My level-3 heading
STRING
ex_1["expected"] = "My level-3 heading"
@@h3_examples << ex_1

# Example 2
ex_2 = Hash.new
ex_2["input"] = <<-STRING
### H3 (###) H2 (##) H1 (#)
STRING
ex_2["expected"] = "H3 (###) H2 (##) H1 (#)"
@@h3_examples << ex_2

# Example 3
ex_3 = Hash.new
ex_3["input"] = <<-STRING
# H1 heading
STRING
ex_3["expected"] = "# H1 heading"
@@h3_examples << ex_3

# Example 4
ex_4 = Hash.new
ex_4["input"] = <<-STRING
## H2 heading
STRING
ex_4["expected"] = "## H2 heading"
@@h3_examples << ex_4

# Example 5
ex_5 = Hash.new
ex_5["input"] = <<-STRING
What happens ### with This?
STRING
ex_5["expected"] = "What happens ### with This?"
@@h3_examples << ex_5

# Example 6
ex_6 = Hash.new
ex_6["input"] = <<-STRING
### Lame.     #######
STRING
ex_6["expected"] = "Lame.     #######"
@@h3_examples << ex_6
  end
  
  def test_parse_h3
    @@h3_examples.each do |example|
      h3_result = parse_h3 example["input"]
      assert_equal example["expected"], h3_result
    end
  end
end
