module Seeds
  module Examples
@@example_hashes = []

# Example 1: I expect 2 elements in an array, 1th index as an 'empty' string.
ex_1 = Hash.new
ex_1["input"] = <<-STRING
0th element

STRING
ex_1["expected"] = ["0th element", ""]
@@example_hashes << ex_1

# Example 2: I expect " " as an array.
ex_2 = Hash.new
ex_2["input"] = <<-STRING
 
STRING
ex_2["expected"] = [" "]
@@example_hashes << ex_2

# Example 3: I expect ["", ""] as an array.
ex_3 = Hash.new
ex_3["input"] = <<-STRING


STRING
ex_3["expected"] = ["", ""]
@@example_hashes << ex_3

# Example 4: I expect ["   ", "  ", " "] as an array.
ex_4 = Hash.new
ex_4["input"] = <<-STRING
   
  
 
STRING
ex_4["expected"] = ["   ", "  ", " "]
@@example_hashes << ex_4

# Example 5: I expect ["", "# This is a level 1 heading", ""] as an array.
ex_5 = Hash.new
ex_5["input"] = <<-STRING

# This is a level 1 heading

STRING
ex_5["expected"] = ["", "# This is a level 1 heading", ""]
@@example_hashes << ex_5

# Example 6: I expect ["","","# This is a level 1 heading","",""] as an array.
ex_6 = Hash.new
ex_6["input"] = <<-STRING


# This is a level 1 heading


STRING
ex_6["expected"] = ["","","# This is a level 1 heading","",""]
@@example_hashes << ex_6

# Example 7: I expect ["", "## This is a level 2 heading"] as an array.
ex_7 = Hash.new
ex_7["input"] = <<-STRING
## This is a level 2 heading
STRING
ex_7["expected"] = ["## This is a level 2 heading"]
@@example_hashes << ex_7

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
@@example_hashes << ex_8

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
@@example_hashes << ex_9

# Example 10: I expect ["Gemini is ruled by Mercury", "My 12th house is Gemini"] as an array
ex_10 = Hash.new
ex_10["input"] = <<-STRING
Gemini is ruled by Mercury
My 12th house is Gemini
STRING
ex_10["expected"] = ["Gemini is ruled by Mercury", "My 12th house is Gemini"]
@@example_hashes << ex_10
  end
end