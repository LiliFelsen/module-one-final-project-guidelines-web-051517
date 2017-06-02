#1# within the no match method, there is a possible endless loop.
# if @restaurant == []
#   no_match
# that part calls the no match method, which asks the user to enter the name again,
# in case it was misspelled. then it sends them back to the find_match method- Where
# the search would presumably come up empty again, sending them back to no_match.


#2# find_match could be several methods.

#3# This if statement in the multiple_restaurants method leaves open the possibiity that the user could enter a
#negative number, or even a string or other unsupported class.
# Solution - add some or statements after the length one.
# || input >= 0 || Integer === input.class

# if input > boros.length
#   puts "Invalid, redirecting you to the menu friend"
#   multiple_restaurants
# elsif
#   puts "You have selected #{@match} in #{boros[input - 1]}, is this correct?
#       enter 1 for yes, or 2 for no"
# end




#?

#in the find_match method, what does the first elsif do? it seems to only
# be setting those instance variables to the hash keys, not actually returning the results.
# its probably just a syntax thing, and they are getting returned.
    #   if @restaurant == []
    #     no_match
    #   elsif @restaurant.length == 1
    #     @boro = restaurant.first[:boro]
    #     @street = restaurant.first[:street]
    #   elsif @restaurant.length > 1
    #     multiple_restaurants
    #   end
    #  end
