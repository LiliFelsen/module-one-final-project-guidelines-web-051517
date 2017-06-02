
require 'pry'
require 'rest-client'
require 'json'

class ApiSearch

    def initialize(match)
      @match = match
      @restaurant = []
      @boro = nil
      @street = nil
      @times_called = 0
    end

     def find_match
# sends out an api call
      data = RestClient.get('https://data.cityofnewyork.us/resource/9w7m-hzhe.json')
# makes a hash of the parsed data
      data_hash = JSON.parse(data)

# iterate over that hash of parsed data. but this first level just has one key, because
# its actually a hash within an array.
      data_hash.each do |hash|
# then it iterates through the hash; each element is one restaurant, with the key going
#through the details, like "name" and the value being the content, like "KFC".
        hash.each do |key, value|
# now if the name is 'name' and its value is the name the user gave, like KFC, then...
          if key == "dba" && value.downcase == @match.downcase
# then push to the restaurant array certain details we want- the name, boro and street
# of the restaurant.
            @restaurant.push({dba:hash["dba"], boro:hash["boro"], street:hash["street"]})
          end
        end
      end

#if @restaurant, which is created as an empty array on initialization, is empty now,
# then call no_match. Basically this means that if the search in the above paragraph
# didn't work, then there must be no match within the database.
      if @restaurant == []
        no_match
      elsif @restaurant.length == 1
        @boro = restaurant.first[:boro]
        @street = restaurant.first[:street]
      elsif @restaurant.length > 1
        multiple_restaurants
      end
     end

#this method gets called if the customer gives a name that turns up nothing within
#the API data. It tells them the restaurant they entered couldn't be found,
#so why not try entering the name again. After that, it calls find_match again.
# one issue here is it might just keep sending you back in an endless loop,
# but that may have been refactored.

     def no_match
       puts "----------------------------------------------------------------------------"
       puts "The restaurant you have entered cannot be found. Maybe you made a spelling"
       puts "error, or perhaps it doesn't exist in our database. Please enter the name again."
       puts "----------------------------------------------------------------------------"

       input = gets.chomp
       @match = input
       @times_called += 1
       if @times_called >= 2
         puts "Input is still invalid. With another failed attempt, program will terminate."
         if @times_called >= 3
           puts "Program ending. Goodbye!"
           exit(0)
         end
       end
       find_match
     end

# this gets called if the initial search, when the API hash is combed for the name
# given by the user, returns multiple restaurants with the same name.
     def multiple_restaurants
# boros is set empty
        boros = []
  # this iterates through the @restaurant array, which holds the results of the
  # API search we did on the name the user gave us. Since the program redirected here,
  # we know that there are more than one element (restaurants) in the array,
  # like 3 dunkin' donuts for example.
        @restaurant.each do |restaurant_hash|
  # if the boros storage array doesn't already include the borough, then push it to
  # the boros array.
          if !boros.include? restaurant_hash[:boro]
           boros.push(restaurant_hash[:boro])
          end
         end

#this tells the customer that mulitple restaurant locations were found, and presents
# a list of the boros the different restaurants were found within. it invites them to
# pick one.
        puts "----------------------------------------------------------------------------"
        puts "Looks like there are multiple locations by that name. Let us know what borough"
        puts "the restaurant was in by entering a number that corresponds to the list below:"
        puts "----------------------------------------------------------------------------"
              boros.each_with_index do |boro, index|
              puts "#{index + 1} #{boro}"
              end
        puts "----------------------------------------------------------------------------"
        input = gets.chomp.to_i

#these account for the user putting in too long a number.
        if input > boros.length || input.to_i <= 0
          puts "----------------------------------------------------------------------------"
          puts "Invalid, redirecting you to the menu friend"
          puts "----------------------------------------------------------------------------"
          multiple_restaurants
        else
          puts "----------------------------------------------------------------------------"
          puts "You have selected #{@match} in #{boros[input - 1].downcase.capitalize}, is"
          puts "this correct?"
          puts "Enter 1 for yes, or 2 for no"
          puts "----------------------------------------------------------------------------"
        end

        input2 = gets.chomp.to_i

        if input2 == 2
          puts "Sorry, redirecting you to the menu"
          multiple_restaurants
        end

        #once we have the right boro from the user, we will output all the
        #restaurant in that boro, and the user can pick it by street
        all_restaurants_in_boros = []
        @restaurant.each do |restaurant_hash|
          if restaurant_hash[:boro] == boros[input - 1]
          all_restaurants_in_boros.push(restaurant_hash)
          end
        end

        puts "----------------------------------------------------------------------------"
        puts "Please pick the restaurant by entering a number from the list below:"
        puts "----------------------------------------------------------------------------"

        all_restaurants_in_boros.each_with_index do |restaurant, index|
          puts "#{index + 1} #{restaurant[:dba]}, #{restaurant[:boro]}, #{restaurant[:street]}"

        end

        puts "----------------------------------------------------------------------------"
        input3 = gets.chomp.to_i

        if input3 > all_restaurants_in_boros.length
          puts "Invalid, redirecting you to the menu friend"
          multiple_restaurants
        end

        puts "----------------------------------------------------------------------------"
        puts "You have selected #{@match} in #{all_restaurants_in_boros[input3 - 1][:street]} #{all_restaurants_in_boros[input3 - 1][:boro]}."
        puts "Is this correct?"
        puts ""
        puts "(Enter 1 for yes, or 2 for no.)"
        puts "----------------------------------------------------------------------------"

        input4 = gets.chomp.to_i


        if input4 == 1
          @boro = all_restaurants_in_boros[input3 - 1][:boro]
          @street = all_restaurants_in_boros[input3 - 1][:street]
          puts "----------------------------------------------------------------------------"
          puts "Sounds good! Your response will saved to the system."
          puts "----------------------------------------------------------------------------"
        elsif input2 == 2
          puts "Sorry, redirecting you to the menu"
          multiple_restaurants
        end
     end
end


# x = ApiSearch.new("DUNKIN' DONUTS")
x = ApiSearch.new("Dunkin' Donuts")

x.find_match
