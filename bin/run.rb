require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'
require 'rest-client'



#yelp info

#client_id = KIt0QQZvI8cA2Gvzix5Ybg
#client_secrete = 7XVzMNIgqhKs7LcycFMG1BKhpqkrHi6vihRMKz0jLi83GT6Mb3cK4xkG550Bv3MJ
#token = TE8FrSLufCGg9AvM8lrz5EkWrpwmhN4mmHBZZjlU2odBXg9W7HBSUljvH0KZYys5YeerIquGFywbFO3rQ2wU8Zz9CiKt5A3I9SL_fzbw8I6ehWCNaydzhDYaNtEuWXYx


#
#   trip = RestClient.get('https://api.yelp.com/v3/businesses/search/location=new+york+city')
#   puts trip
#   puts JSON.parse(trip)
#
#
#
#   {
#   "access_token": "TE8FrSLufCGg9AvM8lrz5EkWrpwmhN4mmHBZZjlU2odBXg9W7HBSUljvH0KZYys5YeerIquGFywbFO3rQ2wU8Zz9CiKt5A3I9SL_fzbw8I6ehWCNaydzhDYaNtEuWXYx",
#   "expires_in": 15551290,
#   "token_type": "Bearer"
# }
