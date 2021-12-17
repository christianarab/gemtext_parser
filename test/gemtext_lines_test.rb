require_relative '../lib/gemtext_lines.rb'
require 'test/unit'

class TestGemtextLines < Test::Unit::TestCase
  include GemtextLines
  
  def setup 
    @gemtext_examples = Array.new
    @std_error_examples = Array.new

ex_1 = Hash.new
ex_1["input"] = <<-STRING
# Review Documents to Review

* Poetry Review
* Film Review
* Review Review
STRING
ex_1["expected"] = ["# Review Documents to Review", "", "* Poetry Review", "* Film Review", "* Review Review"]
@gemtext_examples << ex_1

ex_2 = Hash.new
ex_2["input"] = <<-STRING
The jargon that I know


means a lot


STRING
ex_2["expected"] = ["The jargon that I know", "", "", "means a lot", "", ""]
@gemtext_examples << ex_2

ex_3 = Hash.new
ex_3["input"] = <<-STRING
  baked beans
touching soggy 
scramble

the teflon pan

scratch never with metal
the end.
STRING
ex_3["expected"] = ["  baked beans", "touching soggy ", "scramble", "", "the teflon pan", "", "scratch never with metal", "the end." ]
@gemtext_examples << ex_3

ex_4 = Hash.new
ex_4["input"] = <<-STRING
holy
moonga, you are a
soft soul that left
the coffee sweet
the nicest oak burns in
saturday's fire
friends will be there
we will miss you our
holy moonga

https://www.gofundme.com/f/support-for-moongas-family-friends
STRING
ex_4["expected"] = ["holy", "moonga, you are a", "soft soul that left", "the coffee sweet", "the nicest oak burns in", "saturday's fire", "friends will be there", "we will miss you our", "holy moonga", "", "https://www.gofundme.com/f/support-for-moongas-family-friends" ]
@gemtext_examples << ex_4

ex_5 = Hash.new
ex_5["input"] = <<-STRING
Here in Toronto. We have a lot of food and condos.

Everything is great here.    in Toronto.      

    ... or is it!?  
STRING
ex_5["expected"] = ["Here in Toronto. We have a lot of food and condos.", "", "Everything is great here.    in Toronto.      ", "", "    ... or is it!?  "]
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
