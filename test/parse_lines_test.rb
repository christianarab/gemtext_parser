require_relative '../parse_lines.rb'
require_relative '../type_values.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include ParseLines
  include TypeValues

  def setup
    @parse_lines_examples = Array.new

    # Example 1
    ex_1 = Hash.new
    ex_1["input"] = ["", "This is", "# A test", "## To see", "### if this", "* function", "", "", "> works"]
    ex_1["type_expected"] = [TypeP, TypeP, TypeH1, TypeH2, TypeH3, TypeLi, TypeP, TypeP, TypeBq]
    ex_1["string_expected"] = ["", "This is", "A test", "To see", "if this", "function", "", "", "works"]
    @parse_lines_examples << ex_1

    # Example 2
    ex_2 = Hash.new
    ex_2["input"] = ["# A list of items", "* apple", "* grapefruit", "* bacon"]
    ex_2["type_expected"] = [TypeH1, TypeLi, TypeLi, TypeLi]
    ex_2["string_expected"] = ["A list of items", "apple", "grapefruit", "bacon"]
    @parse_lines_examples << ex_2

    # Example 3
    ex_3 = Hash.new
    ex_3["input"] = ["", "normal", "* list", "## a header"]
    ex_3["type_expected"] = [TypeP, TypeP, TypeLi, TypeH2]
    ex_3["string_expected"] = ["", "normal", "list", "a header"]
    @parse_lines_examples << ex_3

    # Example 4
    ex_4 = Hash.new
    ex_4["input"] = ["> to be or not", "> this is not the question"]
    ex_4["type_expected"] = [TypeBq, TypeBq]
    ex_4["string_expected"] = ["to be or not", "this is not the question"]
    @parse_lines_examples << ex_4

    # Example 5
    ex_5 = Hash.new
    ex_5["input"] = ["", ",", " .. ", "  / / " ]
    ex_5["type_expected"] = [TypeP, TypeP, TypeP, TypeP]
    ex_5["string_expected"] = ["", ",", " .. ", "  / / " ]
    @parse_lines_examples << ex_5

    # Example 6
    ex_6 = Hash.new
    ex_6["input"] = ["=> http://whatwillthisdo.ca hmm", "normal", "* list", "## a header"]
    ex_6["type_expected"] = [TypeLink, TypeP, TypeLi, TypeH2]
    ex_6["string_expected"] = ["hmm", "normal", "list", "a header"]
    ex_6["url_expected"] = ["http://whatwillthisdo.ca"]
    @parse_lines_examples << ex_6

    # Example 7
    ex_7 = Hash.new
    ex_7["input"] = ["=> http://example.com Example page", "# Example", "## Example ", "### Examples"]
    ex_7["type_expected"] = [TypeLink, TypeH1, TypeH2, TypeH3]
    ex_7["string_expected"] = ["Example page", "Example", "Example ", "Examples"]
    ex_7["url_expected"] = ["http://example.com"]
    @parse_lines_examples << ex_7

    # Example 8
    ex_8 = Hash.new
    ex_8["input"] = ["=> http://example1.com Example 1", "=>gopher://example2.com Example 2 ", "=>             smtp://example.com Example 3"]
    ex_8["type_expected"] = [TypeLink, TypeLink, TypeLink]
    ex_8["string_expected"] = ["Example 1", "Example 2", "Example 3"]
    ex_8["url_expected"] = ["http://example1.com", "gopher://example2.com", "smtp://example.com"]
    @parse_lines_examples << ex_8
  end

  def test_parse_lines
    @parse_lines_examples.each do |example|
      type_expected = Array.new
      example["type_expected"].map { |val| type_expected << val }
      string_expected = Array.new
      example["string_expected"].map { |val| string_expected << val }
      url_expected = Array.new
      if example["url_expected"] then example["url_expected"].map { |val| url_expected << val } end
      puts "Here is what is expected: #{string_expected}"
      parse_lines_result = parse_lines example["input"]
      parse_lines_result.each_with_index do |result, index|
        puts "string value: #{result["string"]}"
        puts "parse_lines type: #{result["type"]}" 
        puts "expected type: #{type_expected[index]}"
        puts "expected string: #{string_expected[index]}"
        puts "expected url: #{url_expected[index]}"
        puts "--------"
        assert_equal type_expected[index], result["type"]
        assert_equal string_expected[index], result["string"]
      end
    end
  end
end
