require_relative '../parse_bq.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include ParseBq

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
    ex_4["input"] = "### not a bq example"
    @std_error_examples << ex_4

    # StandardError Example #5
    ex_5 = Hash.new
    ex_5["input"] = "###C# #L # # # O #SE"
    @std_error_examples << ex_5

    # Passing Example #1
    ex_1 = Hash.new
    ex_1["input"] = "> To be or NOT to be"
    ex_1["expected"] = "To be or NOT to be"
    @passing_examples << ex_1

    # Passing Example #2
    ex_2 = Hash.new
    ex_2["input"] = "> Somewhere over the rainbow"
    ex_2["expected"] = "Somewhere over the rainbow"
    @passing_examples << ex_2

    # Passing Example #3
    ex_3 = Hash.new
    ex_3["input"] = "> The strongest of all warriors are these two — Time and Patience."
    ex_3["expected"] = "The strongest of all warriors are these two — Time and Patience."
    @passing_examples << ex_3

    # Passing Example #4
    ex_4 = Hash.new
    ex_4["input"] = "> Long live the new flesh."
    ex_4["expected"] = "Long live the new flesh."
    @passing_examples << ex_4

    # Passing Example #5
    ex_5 = Hash.new
    ex_5["input"] = "> Who wants to want according to a little table?"
    ex_5["expected"] = "Who wants to want according to a little table?"
    @passing_examples << ex_5
  end
  
  def test_parse_bq
    @passing_examples.each do |example|
      bq_result = parse_bq example["input"]
      assert_equal example["expected"], bq_result
    end
  end

  def test_parse_bq_errors
    @std_error_examples.each do |example|
      assert_raise StandardError do
        parse_bq example["input"]
      end
    end
  end
end
