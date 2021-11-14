require '../app.rb'
require './seeds.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include Gemtext::Parser
  include Seeds::Examples

  def setup
    @@example_array
    @file = File.open 'text.gmi'
  end
  
  def test_is_input_valid_file?
    assert_equal File, @file.class
  end

  def test_parsed_output
    @@example_array.each_with_index do |text, idx| 
      assert_equal Array, Gemtext::Parser.start(text).class
      puts idx, "#{Gemtext::Parser.start(text).inspect}"
    end
  end
end
