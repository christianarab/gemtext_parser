require_relative '../lib/gemtext_lines.rb'
require 'test/unit'

class TestGemtextLines < Test::Unit::TestCase
  include GemtextLines
  
  def setup 
    @gemtext_examples = Array.new
    @std_error_examples = Array.new

ex_1 = Hash.new
ex_1["input"] = "# The Title\n\nHello world!\n* one\n* two\n* three\n"
ex_1["expected"] = ["# The Title", "", "Hello world!", "* one", "* two", "* three"]
@gemtext_examples << ex_1

ex_2 = Hash.new
ex_2["input"] = "# The Title\n\nHello world!\n* one\n* two\n* three"
ex_2["expected"] = ["# The Title", "", "Hello world!", "* one", "* two", "* three"]
@gemtext_examples << ex_2

ex_3 = Hash.new
ex_3["input"] = "# A title\r\rHello world!\r\r"
ex_3["expected"] = ["# A title", "", "Hello world!", ""]
@gemtext_examples << ex_3

ex_4 = Hash.new
ex_4["input"] = "# A title\u0085\u0085Hello world!\u0085"
ex_4["expected"] = ["# A title", "", "Hello world!"]
@gemtext_examples << ex_4

ex_5 = Hash.new
ex_5["input"] = "\u0085# A title\u0085\u0085Hello world!\u0085"
ex_5["expected"] = ["", "# A title", "", "Hello world!"]
@gemtext_examples << ex_5

ex_6 = Hash.new
ex_6["input"] = Array.new
@std_error_examples << ex_6

ex_7 = Hash.new
ex_7["input"] = Hash.new
@std_error_examples << ex_7

ex_8 = Hash.new
ex_8["input"] = [" words in here "]
@std_error_examples << ex_8

ex_9 = Hash.new
ex_9["input"] = 232342
@std_error_examples << ex_9

ex_10 = Hash.new
ex_10["input"] = 1
@std_error_examples << ex_10
  end 

  def test_std_error
    @std_error_examples.each do |example|
      assert_raise StandardError do
        gemtext_lines example["input"]
      end
    end
  end

  def test_examples
    @gemtext_examples.each do |example|
      result = gemtext_lines example["input"]
      assert_equal example["expected"], result
    end
  end
end
