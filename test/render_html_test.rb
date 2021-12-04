require_relative '../lib/render_html.rb'
require 'test/unit'

class TestHTMLRender < Test::Unit::TestCase
  include RenderHTML
  
  def setup
    @render_html_examples = Array.new
    @std_error_examples = Array.new

    # Example 1
    ex_1 = Hash.new
    ex_1["input"] = [{"type" => "h1", "string" => "This is an H1"}, {"type" => "# ", "string" => "Also an H1"}]
    ex_1["string_expected"] = "<h1>This is an H1</h1>\n<h1>Also an H1</h1>"
    @render_html_examples << ex_1

    # Example 2
    ex_2 = Hash.new
    ex_2["input"] = [{"type" => "h2", "string" => "This is an H2"}, {"type" => "## ", "string" => "Also an H2"}]
    ex_2["string_expected"] = "<h2>This is an H2</h2>\n<h2>Also an H2</h2>"
    @render_html_examples << ex_2

    # Example 3
    ex_3 = Hash.new
    ex_3["input"] = [{"type" => "h3", "string" => "This is an H3"}, {"type" => "### ", "string" => "Also an H3"}]
    ex_3["string_expected"] = "<h3>This is an H3</h3>\n<h3>Also an H3</h3>"
    @render_html_examples << ex_3

    # Example 4
    ex_4 = Hash.new
    ex_4["input"] = [{"type" => "li", "string" => "barbell"}, {"type" => "* ", "string" => "straps"}]
    ex_4["string_expected"] = "<li>barbell</li>\n<li>straps</li>"
    @render_html_examples << ex_4

    # Example 5
    ex_5 = Hash.new
    ex_5["input"] = [{"type" => "bq", "string" => "What labels me,"}, {"type" => "> ", "string" => "negates me."}]
    ex_5["string_expected"] = "<blockquote>What labels me,</blockquote>\n<blockquote>negates me.</blockquote>"
    @render_html_examples << ex_5

    # Example 6
    ex_6 = Hash.new
    ex_6["input"] = [{"type" => "p", "string" => "Banana phone 13"}]
    ex_6["string_expected"] = "<p>Banana phone 13</p>"
    @render_html_examples << ex_6

    # Example 7
    ex_7 = Hash.new
    ex_7["input"] = [{"type" => "p", "string" => "Banana & Almond Milk & Kale & Ginger & Blueberry"}]
    ex_7["string_expected"] = "<p>Banana &amp; Almond Milk &amp; Kale &amp; Ginger &amp; Blueberry</p>"
    @render_html_examples << ex_7

    # Example 8
    ex_8 = Hash.new
    ex_8["input"] = [{"type" => "h2", "string" => "1 > 0"}]
    ex_8["string_expected"] = "<h2>1 &gt; 0</h2>"
    @render_html_examples << ex_8

    # Example 9
    ex_9 = Hash.new
    ex_9["input"] = [{"type" => "h3", "string" => "1 < 2"}]
    ex_9["string_expected"] = "<h3>1 &lt; 2</h3>"
    @render_html_examples << ex_9

    # Example 10
    ex_10 = Hash.new
    ex_10["input"] = [{"type" => "h3", "string" => "1 << 2"}]
    ex_10["string_expected"] = "<h3>1 &lt;&lt; 2</h3>"
    @render_html_examples << ex_10

    # StandardError Example #1: Not an array.
    ex_11 = Hash.new
    ex_11["input"] = "### My level-3 heading"
    @std_error_examples << ex_11

    # StandardError Example #2: Missing key of 'type' in pair.
    ex_12 = Hash.new
    ex_12["input"] = [{"string" => "Missing the type."}]
    @std_error_examples << ex_12

    # StandardError Example #3: Missing key of 'string' in pair.
    ex_13 = Hash.new
    ex_13["input"] = [{"type" => "Missing the string."}]
    @std_error_examples << ex_13
  end

  def test_render_html
    @render_html_examples.each do |example|
        html_string = render_html example["input"]
        assert_equal example["string_expected"], html_string
    end
  end

  def test_render_html_errors
    @std_error_examples.each do |example|
      assert_raise StandardError do
        render_html example["input"]
      end
    end
  end
end
