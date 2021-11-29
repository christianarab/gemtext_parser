require_relative '../lib/parse_li.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include ParseLi

  def setup
    @passing_examples = Array.new
    @std_error_examples = Array.new

    # StandardError Example #1
    ex_1 = Hash.new
    ex_1["input"] = "### My level-3 heading"
    @std_error_examples << ex_1

    # StandardError Example #2
    ex_2 = Hash.new
    ex_2["input"] = "Testing >> Testing#"
    @std_error_examples << ex_2

    # StandardError Example #3
    ex_3 = Hash.new
    ex_3["input"] = "<THISWONTWORK"
    @std_error_examples << ex_3

    # StandardError Example #4
    ex_4 = Hash.new
    ex_4["input"] = "### not a li example"
    @std_error_examples << ex_4

    # StandardError Example #5
    ex_5 = Hash.new
    ex_5["input"] = "###C# #L # # # O #SE"
    @std_error_examples << ex_5

    # Passing Example #1
    ex_1 = Hash.new
    ex_1["input"] = "* apple"
    ex_1["expected"] = "apple"
    @passing_examples << ex_1

    # Passing Example #2
    ex_2 = Hash.new
    ex_2["input"] = "* *toes"
    ex_2["expected"] = "*toes"
    @passing_examples << ex_2

    # Passing Example #3
    ex_3 = Hash.new
    ex_3["input"] = "* tacos"
    ex_3["expected"] = "tacos"
    @passing_examples << ex_3

    # Passing Example #4
    ex_4 = Hash.new
    ex_4["input"] = "* list item"
    ex_4["expected"] = "list item"
    @passing_examples << ex_4

    # Passing Example #5
    ex_5 = Hash.new
    ex_5["input"] = "* butter?"
    ex_5["expected"] = "butter?"
    @passing_examples << ex_5
  end
  
  def test_parse_li
    @passing_examples.each do |example|
      li_result = parse_li example["input"]
      assert_equal example["expected"], li_result
    end
  end

  def test_parse_li_errors
    @std_error_examples.each do |example|
      assert_raise StandardError do
        parse_li example["input"]
      end
    end
  end
end
