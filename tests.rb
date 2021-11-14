require_relative 'app.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include Gemtext::Parser

  def setup
    @file = File.open 'text.gmi'
    @gmi_string = %q(

      # Title
      
      This is some text.
      
      This is more text.
      
      * apple
      * banana
      * cherry
      
      => https://github.com/reiver @reiver
      )
  end
  
  def test_is_input_valid_file?
    assert_equal File, @file.class
  end

  def test_is_output_an_array?
    assert_equal Array, Gemtext::Parser.start(@file).class
  end

  def test_is_file_eq_to_gemistr?
    assert_equal @gmi_string, @file
  end
end
