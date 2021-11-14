module Seeds
  module Examples
    @ex_1 = 
    %q()

    @ex_2 = 
    %q(
    )

    @ex_3 = 
    %q(

    )

    @ex_4 = 
    %q(



    )

    @ex_5 = 
    %q(

    # This is a level 1 heading

    )

    @ex_6 = 
    %q(## This is a level 2 heading
    )

    @ex_7 =
    %q(

    ## This is a level 2 heading

    )

    @ex_8 =
    %q(

    # This is once

    ## This is twice

    ### This is thrice

    This is fource

    And then what is this?

    )

    @ex_9 =
    %q(Hello world!
    => apple/default.gmni  🗀 A is for Apple
    => banana/default.gmni 🗀 B is for Banana
    => cherry/default.gmni 🗀 C is for Cherry)

    @ex_10 =
    %q(

      # Title
      
      This is some text.
      
      This is more text.
      
      * apple
      * banana
      * cherry
      
      => https://github.com/reiver @reiver
      )

    @@example_array = [@ex_1, @ex_2, @ex_3, @ex_4, @ex_5, @ex_6, @ex_7, @ex_8, @ex_9, @ex_10]
  end
end