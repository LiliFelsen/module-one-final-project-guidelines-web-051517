require_relative '../config/environment'

require 'rest-client'
require 'json'



# data = RestClient.get('https://maps.googleapis.com/maps/api/place/textsearch/json?query=new+york+city+point+of+interest&language=en&key=AIzaSyCII03p1ZtSZTOjq7KT3zY-Fmbbh5QkzqA')
data = RestClient.get('https://api.foursquare.com/v2/venues/explore?near=New+York,New+York&section=food&client_id=H4E1FMOKMYPESZCH5LTUGKHEUNRVOZFTLEURYP2SUHDNUHC1&client_secret=DX4DBSRT0EZID1BKSJ3MGUUSWVPWHYB3FMS31S5BHQ1OKKF5&v=20170528')

# puts data.to_s
# puts data.headers

# data.each do |key, value|
#   value.each do |key2, value2|
#     puts value2
#   end
# end

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
