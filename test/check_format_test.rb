require '../app.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include Gemtext::Parser

  def setup
    @check_format_examples = Array.new

    # Example 1
    ex_1 = Hash.new
    ex_1["input"] = ["", "This is", "# A test", "## To see", "### if this", "* function", "", "", "> works"]
    ex_1["expected"] = ["uf", "uf", "h1", "h2", "h3", "li", "uf", "uf", "bq"]
    @check_format_examples << ex_1

    # Example 2
    ex_2 = Hash.new
    ex_2["input"] = ["# A list of items", "*apple", "*grapefruit", "*bacon"]
    ex_2["expected"] = ["h1", "li", "li", "li"]
    @check_format_examples << ex_2

    # Example 3
    ex_3 = Hash.new
    ex_3["input"] = [" ", "normal", "*list", "## a header"]
    ex_3["expected"] = ["uf", "uf", "li", "h2"]
    @check_format_examples << ex_3

    # Example 4
    ex_4 = Hash.new
    ex_4["input"] = [">to be or not", ">this is not the question"]
    ex_4["expected"] = ["bq", "bq"]
    @check_format_examples << ex_4

    # Example 5
    ex_5 = Hash.new
    ex_5["input"] = ["", ",", " .. ", "  / / " ]
    ex_5["expected"] = ["uf", "uf", "uf", "uf"]
    @check_format_examples << ex_5
end

  def test_check_format
    @check_format_examples.each do |example|
      expected = Array.new
      example["expected"].map { |val| expected << val }
        check_format_result = check_format example["input"]
        check_format_result.each_with_index do |result, index|
          puts "value: #{result["string"]}"
          puts "check_format type: #{result["type"]}" 
          puts "expected value: #{expected[index]}"
          puts "--------"
          assert_equal expected[index], result["type"]
        end
      end
  end
end
