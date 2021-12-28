require_relative '../lib/transcode.rb'
require 'test/unit'

class TranscodeTest < Test::Unit::TestCase
  include Transcode

  def setup
    @transcode_examples = Array.new

    ex_1 = Hash.new
    ex_1["result"] = transcode ["# testing", "## testing"], "terminal"
    ex_1["expected"] = ["\e[41m\e[1m\e[30mtesting\e[0m", "\e[31m\e[1mtesting\e[0m"]
    @transcode_examples << ex_1

    ex_2 = Hash.new
    ex_2["result"] = transcode ["# testing", "## testing"], "html"
    ex_2["expected"] = "<!DOCTYPE html>\n" +
    "<html>\n" +
    "<head></head>\n" +
    "<body>\n" +
    "<h1>testing</h1>\n" +
    "<h2>testing</h2>\n" +
    "</body>\n" +
    "</html>"
    @transcode_examples << ex_2

    ex_3 = Hash.new
    ex_3["result"] = transcode ["# Gemtext", "### Link", "=> www.example.com/link This is the link."], "terminal"
    ex_3["expected"] = ["\e[41m\e[1m\e[30mGemtext\e[0m",
      "\e[1mLink\e[1m\e[0m",
      "\e[48;2;255;199;9m\e[30m⇒ www.example.com/link This is the link.\e[0m"]
    @transcode_examples << ex_3

    ex_4 = Hash.new
    ex_4["result"] = transcode ["# Gemtext", "### Link", "=> www.example.com/link This is the link."], "html"
    ex_4["expected"] = "<!DOCTYPE html>\n" +
    "<html>\n" +
    "<head></head>\n" +
    "<body>\n" +
    "<h1>Gemtext</h1>\n" +
    "<h3>Link</h3>\n" +
    "<div><a href='www.example.com/link'>This is the link.</a></div>\n" +
    "</body>\n" +
    "</html>"
    @transcode_examples << ex_4

    ex_5 = Hash.new
    ex_5["result"] = transcode ["> Quote", "Cherry. # Apples, # Oranges", "* list item"], "terminal"
    ex_5["expected"] = ["“Quote”", "Cherry. # Apples, # Oranges", "• list item"]
    @transcode_examples << ex_5

    ex_6 = Hash.new
    ex_6["result"] = transcode ["> Quote", "Cherry. # Apples, # Oranges", "* list item"], "html"
    ex_6["expected"] = "<!DOCTYPE html>\n" +
    "<html>\n" +
    "<head></head>\n" +
    "<body>\n" +
    "<blockquote>Quote</blockquote>\n" +
    "<p>Cherry. # Apples, # Oranges</p>\n" +
    "<li>list item</li>\n" +
    "</body>\n" +
    "</html>"
    @transcode_examples << ex_6

    ex_7 = Hash.new
    ex_7["result"] = transcode ["# H1", "## H2", "### H3", "* list item", "=> www.example.com link", "> block quote", "p text"], "terminal"
    ex_7["expected"] = ["\e[41m\e[1m\e[30mH1\e[0m",
      "\e[31m\e[1mH2\e[0m",
      "\e[1mH3\e[1m\e[0m",
      "• list item",
      "\e[48;2;255;199;9m\e[30m⇒ www.example.com link\e[0m",
      "“block quote”",
      "p text"]
    @transcode_examples << ex_7

    ex_8 = Hash.new
    ex_8["result"] = transcode ["# H1", "## H2", "### H3", "* list item", "=> www.example.com link", "> block quote", "p text"], "html"
    ex_8["expected"] = "<!DOCTYPE html>\n" +
    "<html>\n" +
    "<head></head>\n" +
    "<body>\n" +
    "<h1>H1</h1>\n" +
    "<h2>H2</h2>\n" +
    "<h3>H3</h3>\n" +
    "<li>list item</li>\n" +
    "<div><a href='www.example.com'>link</a></div>\n" +
    "<blockquote>block quote</blockquote>\n" +
    "<p>p text</p>\n" +
    "</body>\n" +
    "</html>"
    @transcode_examples << ex_8

    ex_9 = Hash.new
    ex_9["result"] = transcode ["=> www.example.com example", "123"], "terminal"
    ex_9["expected"] = ["\e[48;2;255;199;9m\e[30m⇒ www.example.com example\e[0m", "123"]
    @transcode_examples << ex_9

    ex_10 = Hash.new
    ex_10["result"] = transcode ["=> www.example.com example", "123"], "html"
    ex_10["expected"] = "<!DOCTYPE html>\n" +
    "<html>\n" +
    "<head></head>\n" +
    "<body>\n" +
    "<div><a href='www.example.com'>example</a></div>\n" +
    "<p>123</p>\n" +
    "</body>\n" +
    "</html>"
    @transcode_examples << ex_10
  end

  def test_transcode_examples
    @transcode_examples.each_with_index do |example, idx|
      puts "This is Example: #{idx+1}"
      puts example["result"]
      assert_equal example["expected"], example["result"]
    end
  end
end
