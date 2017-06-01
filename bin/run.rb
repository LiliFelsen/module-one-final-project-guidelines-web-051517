require_relative '../config/environment'
require_relative '../app/models/cli.rb'

require 'rest-client'
require 'json'
require 'pry'


puts "Welcome to your Budgeting App!"
new_session = CLI.new
new_session.sign_in
new_session.menu_or_exit
