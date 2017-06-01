
require 'pry'
require 'rest-client'
require 'json'

class ApiSearch

    def initialize(match)
      @match = match
      @restaurant = []
    end

     def find_match
      data = RestClient.get('https://data.cityofnewyork.us/resource/9w7m-hzhe.json')
      data_hash = JSON.parse(data)

      data_hash.each do |hash|
        hash.each do |key, value|
          if key == "dba" && value.downcase == @match.downcase
            @restaurant.push({dba:hash["dba"], boro:hash["boro"], street:hash["street"]})
          end
        end
      end

      if @restaurant == []
        no_match
      elsif @restaurant.length == 1
        puts restaurant.first[:boro] + " " + restaurant.first[:street]
      elsif @restaurant.length > 1
        multiple_restaurants
      end
     end

     def no_match
       puts "The restaurant you have entered cannot be found. Maybe you made a spelling error
       please try again. Maybe it does not exist. Please enter it again"
       input = gets.chomp
       @match = input
       find_match
     end

     def multiple_restaurants
        boros = []
        @restaurant.each do |restaurant_hash|
          if !boros.include? restaurant_hash[:boro]
           boros.push(restaurant_hash[:boro])
          end
         end

        puts "We found multiple restaurant locations, please pick one
              by entering a number that corresponds to the list below"
              boros.each_with_index do |boro, index|
              puts "#{index + 1} #{boro}"
              end
        input = gets.chomp.to_i

        puts "You have selected #{@match} in #{boros[input - 1]}, is this correct?
              enter 1 for yes, or 2 for no"
        input2 = gets.chomp.to_i

        if input2 == 1
          puts "add restaurant and restaurant info"
        elsif input2 == 2
          puts "Sorry, redirecting you to the menu"
          multiple_restaurants
        end
     end
end


x = ApiSearch.new("DUNKIN' DONUTS")

x.find_match
