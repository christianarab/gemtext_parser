require_relative '../lib/parse_lines.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include ParseLines
  
  def setup
    @parse_lines_examples = Array.new

    # Example 1
    ex_1 = Hash.new
    ex_1["input"] = [" ", "This is", "# A test", "## To see", "### if this", "* function", " ", " ", "> works"]
    ex_1["type_expected"] = ["p", "p", "h1", "h2", "h3", "li", "p", "p", "bq"]
    ex_1["string_expected"] = [" ", "This is", "A test", "To see", "if this", "function", " ", " ", "works"]
    @parse_lines_examples << ex_1

    # Example 2
    ex_2 = Hash.new
    ex_2["input"] = ["# A list of items", "* apple", "* grapefruit", "* bacon"]
    ex_2["type_expected"] = ["h1", "li", "li", "li"]
    ex_2["string_expected"] = ["A list of items", "apple", "grapefruit", "bacon"]
    @parse_lines_examples << ex_2

    # Example 3
    ex_3 = Hash.new
    ex_3["input"] = [" ", "normal", "* list", "## a header"]
    ex_3["type_expected"] = ["p", "p", "li", "h2"]
    ex_3["string_expected"] = [" ", "normal", "list", "a header"]
    @parse_lines_examples << ex_3

    # Example 4
    ex_4 = Hash.new
    ex_4["input"] = ["> to be or not", "> this is not the question"]
    ex_4["type_expected"] = ["bq", "bq"]
    ex_4["string_expected"] = ["to be or not", "this is not the question"]
    @parse_lines_examples << ex_4

    # Example 5
    ex_5 = Hash.new
    ex_5["input"] = [" ", ",", " .. ", "  / / " ]
    ex_5["type_expected"] = ["p", "p", "p", "p"]
    ex_5["string_expected"] = [" ", ",", " .. ", "  / / " ]
    @parse_lines_examples << ex_5
  end

  def test_parse_lines
    @parse_lines_examples.each do |example|
      type_expected = Array.new
      example["type_expected"].map { |val| type_expected << val }
      string_expected = Array.new
      example["string_expected"].map { |val| string_expected << val }
      parse_lines_result = parse_lines example["input"]
      parse_lines_result.each_with_index do |result, index|
        puts "string value: #{result["input"]}"
        puts "parse_lines type: #{result["type"]}" 
        puts "expected type: #{type_expected[index]}"
        puts "expected string: #{string_expected[index]}"
        puts "--------"
        assert_equal type_expected[index], result["type"]
        assert_equal string_expected[index], result["string"]
      end
    end
  end
end
