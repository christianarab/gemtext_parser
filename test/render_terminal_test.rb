require_relative '../lib/render_terminal.rb'
require_relative '../lib/type_values.rb'
require 'test/unit'

class TestTerminalRender < Test::Unit::TestCase
  include RenderTerminal
  include TypeValues
  
  def setup
    @render_terminal_examples = Array.new
    @std_error_examples = Array.new

    ex_1 = Hash.new
    ex_1["input"] = [{"type" => TypeH1, "string" => "For h1, make the text bold and the background color red, and the text color black."}]
    ex_1["string_expected"] = ["\e[41m\e[1m\e[30mFor h1, make the text bold and the background color red, and the text color black.\e[0m"]
    @render_terminal_examples << ex_1

    ex_2 = Hash.new
    ex_2["input"] = [{"type" => TypeH2, "string" => "For h2, make the text bold and the text color red."}]
    ex_2["string_expected"] = ["\e[31m\e[1mFor h2, make the text bold and the text color red.\e[0m"]
    @render_terminal_examples << ex_2

    ex_3 = Hash.new
    ex_3["input"] = [{"type" => TypeH3, "string" => "For h3, make the text bold."}]
    ex_3["string_expected"] = ["\e[1mFor h3, make the text bold.\e[1m\e[0m"]
    @render_terminal_examples << ex_3

    ex_4 = Hash.new
    ex_4["input"] = [{"type" => TypeLink, "url" => "https://www.example.com/", "string" => "For link, prefix it with' ⇒ ', and change the color of the text, so that its background color is rgb(255,199,6) and its foreground color is black (i.e., rgb(0, 0, 0))."}]
    ex_4["string_expected"] = ["\e[48;2;255;199;9m\e[30m⇒ https://www.example.com/ For link, prefix it with' ⇒ ', and change the color of the text, so that its background color is rgb(255,199,6) and its foreground color is black (i.e., rgb(0, 0, 0)).\e[0m"]
    @render_terminal_examples << ex_4

    ex_5 = Hash.new
    ex_5["input"] = [{"type" => TypeBq, "string" => "For bq, prefix it with “ and suffix it with ”."}]
    ex_5["string_expected"] = ["“For bq, prefix it with “ and suffix it with ”.”"]
    @render_terminal_examples << ex_5

    ex_6 = Hash.new
    ex_6["input"] = [{"type" => TypeLi, "string" => "For li, prefix it with '• '. (That • character is a bullet symbol.)"}]
    ex_6["string_expected"] = ["• For li, prefix it with '• '. (That • character is a bullet symbol.)"]
    @render_terminal_examples << ex_6

    ex_7 = Hash.new
    ex_7["input"] = [{"type" => TypeP, "string" => "Test test."}]
    ex_7["string_expected"] = ["Test test."]
    @render_terminal_examples << ex_7

    ex_8 = Hash.new
    ex_8["input"] = [{"type" => "111111111111", "string" => "Dummy text."}]
    @std_error_examples << ex_8
  end

  def test_render_terminal
    @render_terminal_examples.each do |example|
        terminal_line = render_terminal example["input"]
        puts terminal_line
        assert_equal example["string_expected"], terminal_line
    end
  end

  def test_render_terminal_std_errors
    @std_error_examples.each do |example|
      assert_raise StandardError do
        render_terminal example["input"]
      end
    end
  end
end
