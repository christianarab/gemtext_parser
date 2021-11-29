require_relative '../lib/parse_h3.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include ParseH3

  def setup
    @passing_examples = Array.new
    @std_error_examples = Array.new

    # StandardError Example #1
    ex_1 = Hash.new
    ex_1["input"] = "#### My level-4 heading"
    @std_error_examples << ex_1

    # StandardError Example #2
    ex_2 = Hash.new
    ex_2["input"] = "# Testing # Testing#"
    @std_error_examples << ex_2

    # StandardError Example #3
    ex_3 = Hash.new
    ex_3["input"] = "###THISWONTWORK"
    @std_error_examples << ex_3

    # StandardError Example #4
    ex_4 = Hash.new
    ex_4["input"] = "* not a h3 example"
    @std_error_examples << ex_4

    # StandardError Example #5
    ex_5 = Hash.new
    ex_5["input"] = "##C# #L ### # # O #SE"
    @std_error_examples << ex_5

    # Passing Example #1
    ex_1 = Hash.new
    ex_1["input"] = "### What happens ## with This?"
    ex_1["expected"] = "What happens ## with This?"
    @passing_examples << ex_1

    # Passing Example #2
    ex_2 = Hash.new
    ex_2["input"] = "### Where am I?"
    ex_2["expected"] = "Where am I?"
    @passing_examples << ex_2

    # Passing Example #3
    ex_3 = Hash.new
    ex_3["input"] = "### S HOPPING # LIST"
    ex_3["expected"] = "S HOPPING # LIST"
    @passing_examples << ex_3

    # Passing Example #4
    ex_4 = Hash.new
    ex_4["input"] = "### VERY COOL"
    ex_4["expected"] = "VERY COOL"
    @passing_examples << ex_4

    # Passing Example #5
    ex_5 = Hash.new
    ex_5["input"] = "### My capsule... # ## ### *   "
    ex_5["expected"] = "My capsule... # ## ### *   "
    @passing_examples << ex_5
  end
  
  def test_parse_h3
    @passing_examples.each do |example|
      h3_result = parse_h3 example["input"]
      assert_equal example["expected"], h3_result
    end
  end

  def test_parse_h3_errors
    @std_error_examples.each do |example|
      assert_raise StandardError do
        parse_h3 example["input"]
      end
    end
  end
end
