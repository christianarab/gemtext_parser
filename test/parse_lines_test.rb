require_relative '../lib/parse_lines.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include ParseLines
  
  def setup
    @parse_lines_examples = Array.new

    # Example 1
    ex_1 = Hash.new
    ex_1["input"] = ["", "This is", "# A test", "## To see", "### if this", "* function", "", "", "> works"]
    ex_1["expected"] = ["p", "p", "h1", "h2", "h3", "li", "p", "p", "bq"]
    @parse_lines_examples << ex_1

    # Example 2
    ex_2 = Hash.new
    ex_2["input"] = ["# A list of items", "* apple", "* grapefruit", "* bacon"]
    ex_2["expected"] = ["h1", "li", "li", "li"]
    @parse_lines_examples << ex_2

    # Example 3
    ex_3 = Hash.new
    ex_3["input"] = [" ", "normal", "* list", "## a header"]
    ex_3["expected"] = ["p", "p", "li", "h2"]
    @parse_lines_examples << ex_3

    # Example 4
    ex_4 = Hash.new
    ex_4["input"] = ["> to be or not", "> this is not the question"]
    ex_4["expected"] = ["bq", "bq"]
    @parse_lines_examples << ex_4

    # Example 5
    ex_5 = Hash.new
    ex_5["input"] = ["", ",", " .. ", "  / / " ]
    ex_5["expected"] = ["p", "p", "p", "p"]
    @parse_lines_examples << ex_5
end

  def test_parse_lines
    @parse_lines_examples.each do |example|
      expected = Array.new
      example["expected"].map { |val| expected << val }
      parse_lines_result = parse_lines example["input"]
      parse_lines_result.each_with_index do |result, index|
        puts "string value: #{result["string"]}"
        puts "parse_lines type: #{result["type"]}" 
        puts "expected type: #{expected[index]}"
        puts "--------"
        assert_equal expected[index], result["type"]
      end
    end
  end
end
