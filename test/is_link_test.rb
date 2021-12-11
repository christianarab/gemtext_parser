require_relative '../lib/is_link.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include IsLink

  def setup
    @is_link_examples = Array.new
    
    ex_1 = Hash.new
    ex_1["input"] = "=> http://linkornot.com Link"
    ex_1["expected"] = true
    @is_link_examples << ex_1

    ex_2 = Hash.new
    ex_2["input"] = "=< http://linkornot.com Not a link"
    ex_2["expected"] = false
    @is_link_examples << ex_2

    ex_3 = Hash.new
    ex_3["input"] = "=>http://example.com Link"
    ex_3["expected"] = true
    @is_link_examples << ex_3

    ex_4 = Hash.new
    ex_4["input"] = "# http://example.com Not a Link"
    ex_4["expected"] = false
    @is_link_examples << ex_4

    ex_5 = Hash.new
    ex_5["input"] = "=> http://somelink.ca Some Link"
    ex_5["expected"] = true
    @is_link_examples << ex_5
  end
  
  def test_is_link
    @is_link_examples.each do |example|
      is_link_result = is_link? example["input"]
      assert_equal example["expected"], is_link_result
    end
  end
end
