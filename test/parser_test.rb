require_relative '../parser.rb'
require_relative '../start.rb'
require 'test/unit'

class TestParser < Test::Unit::TestCase
  include Parser
  include Start

  def setup
    @@parser_examples = Array.new
    @file = File.open 'text.gmi'
# Example 1: I expect 2 elements in an array, 1th index as an 'empty' string.
ex_1 = Hash.new
ex_1["input"] = <<-STRING
0th element

STRING
ex_1["expected"] = ["0th element", ""]
@@parser_examples << ex_1

# Example 2: I expect " " as an array.
ex_2 = Hash.new
ex_2["input"] = <<-STRING
 
STRING
ex_2["expected"] = [" "]
@@parser_examples << ex_2

# Example 3: I expect ["", ""] as an array.
ex_3 = Hash.new
ex_3["input"] = <<-STRING


STRING
ex_3["expected"] = ["", ""]
@@parser_examples << ex_3

# Example 4: I expect ["   ", "  ", " "] as an array.
ex_4 = Hash.new
ex_4["input"] = <<-STRING
   
  
 
STRING
ex_4["expected"] = ["   ", "  ", " "]
@@parser_examples << ex_4

# Example 5: I expect ["", "# This is a level 1 heading", ""] as an array.
ex_5 = Hash.new
ex_5["input"] = <<-STRING

# This is a level 1 heading

STRING
ex_5["expected"] = ["", "# This is a level 1 heading", ""]
@@parser_examples << ex_5

# Example 6: I expect ["","","# This is a level 1 heading","",""] as an array.
ex_6 = Hash.new
ex_6["input"] = <<-STRING


# This is a level 1 heading


STRING
ex_6["expected"] = ["","","# This is a level 1 heading","",""]
@@parser_examples << ex_6

# Example 7: I expect ["## This is a level 2 heading"] as an array.
ex_7 = Hash.new
ex_7["input"] = <<-STRING
## This is a level 2 heading
STRING
ex_7["expected"] = ["## This is a level 2 heading"]
@@parser_examples << ex_7

# Example 8: I expect ["", "", "# This is once", "", "## This is twice", "", 
# "### This is thrice", "", "This is fource", "", "And then what is this?", ""] as an array.
ex_8 = Hash.new
ex_8["input"] = <<-STRING


# This is once

## This is twice

### This is thrice

This is fource

And then what is this?

STRING
ex_8["expected"] = ["", "", "# This is once", "", "## This is twice", "", 
                  "### This is thrice", "", "This is fource", "", "And then what is this?", ""]
@@parser_examples << ex_8

# Example 9: I expect ["Hello world!", "=> apple/default.gmni  🗀 A is for Apple", "=> banana/default.gmni 🗀 B is for Banana", 
# "=> cherry/default.gmni 🗀 C is for Cherry"] as an array.
ex_9 = Hash.new
ex_9["input"] = <<-STRING
Hello world!
=> apple/default.gmni  🗀 A is for Apple
=> banana/default.gmni 🗀 B is for Banana
=> cherry/default.gmni 🗀 C is for Cherry
STRING
ex_9["expected"] = ["Hello world!", "=> apple/default.gmni  🗀 A is for Apple", "=> banana/default.gmni 🗀 B is for Banana", 
                    "=> cherry/default.gmni 🗀 C is for Cherry"] 
@@parser_examples << ex_9

# Example 10: I expect ["Gemini is ruled by Mercury", "My 12th house is Gemini"] as an array
ex_10 = Hash.new
ex_10["input"] = <<-STRING
Gemini is ruled by Mercury
My 12th house is Gemini
STRING
ex_10["expected"] = ["Gemini is ruled by Mercury", "My 12th house is Gemini"]
@@parser_examples << ex_10
  
# Example 11: I expect ln. 129-130 as an array.
ex_11 = Hash.new
ex_11["input"] = <<-STRING

# Capsules
## The first 3
=> gemini://example.com/alpha.gmni
=> gemini://example.com/beta.gmni
=> gemini://example.com/gamma.gmni

More to come .   .    .

STRING
ex_11["expected"] = ["", "# Capsules", "## The first 3", "=> gemini://example.com/alpha.gmni", "=> gemini://example.com/beta.gmni", 
                    "=> gemini://example.com/gamma.gmni", "", "More to come .   .    .", ""]
@@parser_examples << ex_11

# Example 12: I expect ln. 145-148 as an array
ex_12 = Hash.new
ex_12["input"] = <<-STRING

## Description of Gemini

> An upright, tall, straight Body: either in Man or Woman the Complexion sanguine, not cleer, but obscure and dark, long Arms, but many times the Hands and Feet short and very fleshy; a dark Hair, almost Black; a strong, active Body, a good piercing hazel Eye, and wanton, and of perfect sight, of excellent understanding, and judicious in wordly affairs.
- William Lilly's Christian Astrology (1st ed. 1647, reprinted 1985 Regulus)

STRING
ex_12["expected"] = [
                    "", "## Description of Gemini", "",
                    "> An upright, tall, straight Body: either in Man or Woman the Complexion sanguine, not cleer, but obscure and dark, long Arms, but many times the Hands and Feet short and very fleshy; a dark Hair, almost Black; a strong, active Body, a good piercing hazel Eye, and wanton, and of perfect sight, of excellent understanding, and judicious in wordly affairs.",
                    "- William Lilly's Christian Astrology (1st ed. 1647, reprinted 1985 Regulus)",
                    ""
                    ]
@@parser_examples << ex_12

# Example 13: I expect ["```","gemini supports preformatted text", "```", "=> gemini://example.com/example.gmni"] as an array.
ex_13 = Hash.new
ex_13["input"] = <<-STRING
```
gemini supports preformatted text
```
=> gemini://example.com/example.gmni
STRING
ex_13["expected"] = ["```","gemini supports preformatted text", "```", "=> gemini://example.com/example.gmni"]
@@parser_examples << ex_13

# Example 14: I expect ln. 173-182 as an array.
ex_14 = Hash.new
ex_14["input"] = <<-STRING
# Claudius Ptolemy - TETRABIBLOS except
Published in the Loeb Classical Library, 1940.
The text is in the public domain.

Mercury in general is found at certain times alike to be drying and absorptive of moisture,
because he never is far removed in longitude from the heat of the sun; and again humidifying,
because he is next above the sphere of the moon, which is closest to the earth; and to change quickly from one to the other,
inspired as it were by the speed of his motion in the neighbourhood of the sun itself.
STRING
ex_14["expected"] = [
                    "# Claudius Ptolemy - TETRABIBLOS except",
                    "Published in the Loeb Classical Library, 1940.",
                    "The text is in the public domain.",
                    "",
                    "Mercury in general is found at certain times alike to be drying and absorptive of moisture,",
                    "because he never is far removed in longitude from the heat of the sun; and again humidifying,",
                    "because he is next above the sphere of the moon, which is closest to the earth; and to change quickly from one to the other,",
                    "inspired as it were by the speed of his motion in the neighbourhood of the sun itself."
                    ]
@@parser_examples << ex_14

# Example 15: I expect ln. 199-208 as an array.
ex_15 = Hash.new
ex_15["input"] = <<-STRING

# Astrology books recommended

* Astrology and Cosmology in the World’s Religions by Nicholas Campion
* Hellenistic Astrology: The Study of Fate and Fortune by Chris Brennan
* Planets in Youth: Patterns of Early Development by Robert Hand
* Ancient Astrology in Theory and Practice: A Manual of Traditional Techniques, Volume I: Assessing Planetary Condition by Demetra George
* Carmen Astrologicum: The 'Umar al-Tabari Translation by Dorotheus of Sidon & 'Umar al-Tabari
STRING
ex_15["expected"] = [
                    "",
                    "# Astrology books recommended",
                    "",
                    "* Astrology and Cosmology in the World’s Religions by Nicholas Campion",
                    "* Hellenistic Astrology: The Study of Fate and Fortune by Chris Brennan",
                    "* Planets in Youth: Patterns of Early Development by Robert Hand",
                    "* Ancient Astrology in Theory and Practice: A Manual of Traditional Techniques, Volume I: Assessing Planetary Condition by Demetra George",
                    "* Carmen Astrologicum: The 'Umar al-Tabari Translation by Dorotheus of Sidon & 'Umar al-Tabari",
                    ]
@@parser_examples << ex_15

# Example 16: I expect ["* heights", "* blood pressure", "* anxiety"] as an array.
ex_16 = Hash.new
ex_16["input"] = <<-STRING
* heights
* blood pressure
* anxiety
STRING
ex_16["expected"] = ["* heights", "* blood pressure", "* anxiety"]
@@parser_examples << ex_16

# Example 17: I expect ["## Heights", "## Blood Pressure", "", "", "", "## Anxiety"] as an array.
ex_17 = Hash.new
ex_17["input"] = <<-STRING
## Heights
## Blood Pressure



## Anxiety
STRING
ex_17["expected"] = ["## Heights", "## Blood Pressure", "", "", "", "## Anxiety"]
@@parser_examples << ex_17

# Example 18: I expect ["```", "He is", "Set to self-destruct", "Self-destruct", "Self-destruct", "```", "- Lyrics by The Slits, Instant Hit"] as an array.
ex_18 = Hash.new
ex_18["input"] = <<-STRING
```
He is
Set to self-destruct
Self-destruct
Self-destruct
```
- Lyrics by The Slits, Instant Hit
STRING
ex_18["expected"] = ["```", "He is", "Set to self-destruct", "Self-destruct", "Self-destruct", "```", "- Lyrics by The Slits, Instant Hit"]
@@parser_examples << ex_18

# Example 19: I expect ["# Tic", "### Toc", "## Tic", "## Tic", "# Toc"] as an array.
ex_19 = Hash.new
ex_19["input"] = <<-STRING
# Tic
### Toc
## Tic
## Tic
# Toc
STRING
ex_19["expected"] = ["# Tic", "### Toc", "## Tic", "## Tic", "# Toc"]
@@parser_examples << ex_19

# Example 20: I expect ["# Testing", "one,  ", "  three,", ",,,two           "] as an array.
ex_20 = Hash.new
ex_20["input"] = <<-STRING
# Testing
one,  
  three,
,,,two           
STRING
ex_20["expected"] = ["# Testing", "one,  ", "  three,", ",,,two           "]
@@parser_examples << ex_20
  end
  
  def test_is_input_valid_file?
    assert_equal File, @file.class
  end

  def test_examples
    @@parser_examples.each do |example|
      parsed_result = start example["input"]
      puts "Parsed example output: #{parsed_result}"
      assert_equal example["expected"], parsed_result
    end
  end
end
