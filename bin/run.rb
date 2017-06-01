require_relative '../config/environment'
require_relative '../app/models/cli.rb'

require 'rest-client'
require 'json'
require 'pry'
<<<<<<< HEAD




#yelp info

#client_id = KIt0QQZvI8cA2Gvzix5Ybg
#client_secrete = 7XVzMNIgqhKs7LcycFMG1BKhpqkrHi6vihRMKz0jLi83GT6Mb3cK4xkG550Bv3MJ
#token = TE8FrSLufCGg9AvM8lrz5EkWrpwmhN4mmHBZZjlU2odBXg9W7HBSUljvH0KZYys5YeerIquGFywbFO3rQ2wU8Zz9CiKt5A3I9SL_fzbw8I6ehWCNaydzhDYaNtEuWXYx
=======
>>>>>>> c5ba83418889f3eaf743d43e46ee5bb06794d1fe


puts "Welcome to your Budgeting App!"
new_session = CLI.new
new_session.sign_in
new_session.menu_or_exit
