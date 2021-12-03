require_relative '../lib/render_html.rb'
require 'test/unit'

class TestHTMLRender < Test::Unit::TestCase
  include RenderHTML
  
  def setup
    @render_html_examples = Array.new

    # Example 1
    ex_1 = Hash.new
    ex_1["input"] = ["# This is an H1"]
    ex_1["string_expected"] = "<h1>This is an H1</h1>"
    @render_html_examples << ex_1

    # Example 2
    ex_2 = Hash.new
    ex_2["input"] = ["## This is an H2"]
    ex_2["string_expected"] = "<h2>This is an H2</h2>"
    @render_html_examples << ex_2

    # Example 3
    ex_3 = Hash.new
    ex_3["input"] = ["### This is an H3"]
    ex_3["string_expected"] = "<h3>This is an H3</h3>"
    @render_html_examples << ex_3

    # Example 4
    ex_4 = Hash.new
    ex_4["input"] = ["* This is a list item"]
    ex_4["string_expected"] = "<li>This is a list item</li>"
    @render_html_examples << ex_4

    # Example 5
    ex_5 = Hash.new
    ex_5["input"] = ["> What labels me, negates me." ]
    ex_5["string_expected"] = "<bq>What labels me, negates me.</bq>"
    @render_html_examples << ex_5

    # Example 6
    ex_6 = Hash.new
    ex_6["input"] = ["Banana phone 13"]
    ex_6["string_expected"] = "<p>Banana phone 13</p>"
    @render_html_examples << ex_6
  end

  def test_render_html
    @render_html_examples.each do |example|
        html_string = render_html example["input"]
        assert_equal example["string_expected"], html_string
    end
  end
end
