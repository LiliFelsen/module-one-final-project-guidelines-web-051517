require_relative '../config/environment'
<<<<<<< HEAD
require_relative '../app/models/cli.rb'

require 'rest-client'
require 'json'
require 'pry'
=======

require 'rest-client'
require 'json'



# data = RestClient.get('https://maps.googleapis.com/maps/api/place/textsearch/json?query=new+york+city+point+of+interest&language=en&key=AIzaSyCII03p1ZtSZTOjq7KT3zY-Fmbbh5QkzqA')
data = RestClient.get('https://api.foursquare.com/v2/venues/explore?near=New+York,New+York&section=food&client_id=H4E1FMOKMYPESZCH5LTUGKHEUNRVOZFTLEURYP2SUHDNUHC1&client_secret=DX4DBSRT0EZID1BKSJ3MGUUSWVPWHYB3FMS31S5BHQ1OKKF5&v=20170528')

# puts data.to_s
# puts data.headers
>>>>>>> c2187bc0735b38079b814e850a22f58381c37245

# data.each do |key, value|
#   value.each do |key2, value2|
#     puts value2
#   end
# end

<<<<<<< HEAD
puts "Welcome to your Budgeting App!"
new_session = CLI.new
new_session.sign_in
=======
# puts JSON.parse(data)
#
# hash_as_string = hash_object.to_json
#
# my_hash = JSON.load(File.read('data'))
# https://stackoverflow.com/questions/40567108/ruby-convert-string-to-hash


#CLI example:
-interpolate their answer, which is the name of the restuarant, into the appriopriate place in the
search api url.
-then grab the first match
>>>>>>> c2187bc0735b38079b814e850a22f58381c37245
