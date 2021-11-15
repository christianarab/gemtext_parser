require '../app.rb'
require './seeds.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include Gemtext::Parser
  include Seeds::Examples

  def setup
    @@example_set_1
    @@example_set_2
    @file = File.open 'text.gmi'
  end
  
  def test_is_input_valid_file?
    assert_equal File, @file.class
  end

  def test_examples
    @@example_set_1.each do |hash|
      input = hash["input"]
      parsed_value = Gemtext::Parser.start input
      puts parsed_value
      assert_equal hash["expected"], parsed_value
    end
    @@example_set_2.each do |hash|
      input = hash["input"]
      parsed_value = Gemtext::Parser.start input
      puts parsed_value
      assert_equal hash["expected"], parsed_value
    end
  end
end
