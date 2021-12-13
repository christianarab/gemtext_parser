require_relative '../lib/parse_link.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include ParseLink

  def setup
    @passing_examples = Array.new
    @std_error_examples = Array.new

    # StandardError Example #1
    ex_1 = Hash.new
    ex_1["input"] = "               => notformated.com corrently"
    @std_error_examples << ex_1

    # StandardError Example #2
    ex_2 = Hash.new
    ex_2["input"] =  "## notformated corrently"
    @std_error_examples << ex_2

    # StandardError Example #3
    ex_3 = Hash.new
    ex_3["input"] = "= www.stillnot.com formatted"
    @std_error_examples << ex_3

    # StandardError Example #4
    ex_4 = Hash.new
    ex_4["input"] = "!b => !a"
    @std_error_examples << ex_4

    # StandardError Example #5
    ex_5 = Hash.new
    ex_5["input"] = "not correct!"
    @std_error_examples << ex_5

    # Passing Example #1
    ex_1 = Hash.new
    ex_1["input"] = "=> http://www.example.com example passing"
    ex_1["expected"] = [{"url" => "http://www.example.com", "string" => "example passing"}]
    @passing_examples << ex_1

    # Passing Example #2
    ex_2 = Hash.new
    ex_2["input"] = "=>http://www.example.com example passing again but this time there is no space and more string"
    ex_2["expected"] = [{"url" => "http://www.example.com", "string" => "example passing again but this time there is no space and more string"}]
    @passing_examples << ex_2

    # Passing Example #3
    ex_3 = Hash.new
    ex_3["input"] = "=> gemini://example.com A supremely cool Gemini capsule"
    ex_3["expected"] = [{"url" => "gemini://example.com", "string" => "A supremely cool Gemini capsule"}]
    @passing_examples << ex_3

    # Passing Example #4
    ex_4 = Hash.new
    ex_4["input"] = "=>gemini://example.com"
    ex_4["expected"] = [{"url" => "gemini://example.com", "string" => ""}]
    @passing_examples << ex_4

    # Passing Example #5
    ex_5 = Hash.new
    ex_5["input"] = "=> smtp://example.com    another smtp"
    ex_5["expected"] = [{"url" => "smtp://example.com", "string" => "another smtp"}]
    @passing_examples << ex_5
  end
  
  def test_parse_link
    @passing_examples.each do |example|
      link_result = parse_link example["input"]
      assert_equal example["expected"], link_result
    end
  end

  def test_parse_link_errors
    @std_error_examples.each do |example|
      assert_raise StandardError do
        parse_link example["input"]
      end
    end
  end
end
