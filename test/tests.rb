require '../app.rb'
require './seeds.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include Gemtext::Parser
  include Seeds::Examples

  def setup
    @@example_set_1
    @@example_set_2
    @@example_heading_1_set
    @file = File.open 'text.gmi'
  end
  
  def test_is_input_valid_file?
    assert_equal File, @file.class
  end

  def test_examples
    @@example_set_1.each do |example|
      input = example["input"]
      parsed_value = start input
      puts parsed_value
      assert_equal example["expected"], parsed_value
    end
    @@example_set_2.each do |example|
      input = example["input"]
      parsed_value = start input
      puts parsed_value
      assert_equal example["expected"], parsed_value
    end

    def test_heading_1
      @@example_heading_1_set.each do |example|
        input = example["input"]
        result = check_heading example
        puts result
        assert_equal example["expected"], result
      end
    end
  end
end
