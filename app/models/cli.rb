require 'pry'
require 'colorize'
require 'ansi'

class CLI

  attr_accessor :user

  def initialize
    @user = nil
  end

  def sign_in
    puts "Are you a new user? (Y/N)"
    puts "-------------------------------------------------"
    input = gets.downcase.strip
      case input
      when 'y'
        puts "-------------------------------------------------"
        puts "Please create a username:"
        puts "-------------------------------------------------"
        username_validation
        new_user_menu
      when 'n'
        puts "-------------------------------------------------"
        puts "What is your username?"
        puts "-------------------------------------------------"
        username_input = gets.downcase.strip
        @user = User.find_by(username: username_input)
          if !@user
            puts "-------------------------------------------------"
            puts "Sorry, you do not have an account yet.\n Create a username:"
            puts "-------------------------------------------------"
            username_validation
            new_user_menu
          else
            main_menu
          end
      end
  end

  def main_menu
    puts "-------------------------------------------------"
    puts "What do you want to do?"
    puts "1. Add a new visit"
    puts "2. Update the grade of an existing place"
    puts "3. Delete an existing place"
    puts "4. See your personal reports"
    puts "5. Exit"
    puts "-------------------------------------------------"
    userchoice = gets.chomp.to_i
      case userchoice
      when 1
        add_visit
      when 2
        update_grade
      when 3
        delete_place
      when 4
        see_spending
      when 5
        puts "Goodbye"
        exit(0)
      else
        puts "Sorry, this is not a valid command.".colorize(:red)
        main_menu
      end
      menu_or_exit
  end

  def new_user_menu
    puts "-------------------------------------------------"
    puts "You can now create a place and grade it!"
    puts "Where did you go?"
    puts "-------------------------------------------------"
    place_input = gets.downcase.strip
    visited_place = Place.create(name: place_input)
    puts "-------------------------------------------------"
    puts "How much did you spend?"
    puts "-------------------------------------------------"
    spending_input = gets.chomp.to_i
    puts "-------------------------------------------------"
    puts "How was it? (0 for terrible, 5 for amazing)"
    puts "-------------------------------------------------"
    grade_input = gets.chomp.to_i
      if !grade_input.between?(0,5)
        while !grade_input.between?(0,5)
          puts "Grade needs to be between 0 and 5. Enter a new grade:".colorize(:red)
          grade_input = gets.chomp.to_i
        end
      end
    VisitedPlace.create(place_id: visited_place.id, money_spent: spending_input, user_id: @user.id, grade: grade_input)
    main_menu
  end

  def add_visit
    puts "-------------------------------------------------"
    puts "You can:"
    puts "1. Add a new visit to an existing place"
    puts "2. Create a new place and give it a grade"
    puts "3. Exit"
    puts "-------------------------------------------------"
    userchoice = gets.chomp.to_i
    case userchoice
    when 1
      puts "-------------------------------------------------"
      puts "Here are all the places you went to:"
      user_all_places = @user.visited_places.map {|visitedplace| visitedplace.place.name}
      user_all_places_names = user_all_places.each {|e| puts e.capitalize}
      puts "Which one did you went back to?"
      puts "-------------------------------------------------"
      place_input = gets.downcase.strip
      visited_place = Place.find_by(name: place_input)
      puts "-------------------------------------------------"
      puts "How much did you spend?"
      puts "-------------------------------------------------"
      spending_input = gets.chomp.to_i
      new_visit = VisitedPlace.find_by(place_id: visited_place.id)
      new_visit.money_spent += spending_input
      new_visit.visits += 1
    when 2
      puts "-------------------------------------------------"
      puts "What is the name of this new place?"
      puts "-------------------------------------------------"
      place_input = gets.downcase.strip
      visited_place = Place.create(name: place_input)
      puts "-------------------------------------------------"
      puts "How much did you spend?"
      puts "-------------------------------------------------"
      spending_input = gets.chomp.to_i
      puts "-------------------------------------------------"
      puts "How was it? (0 for terrible, 5 for amazing)"
      puts "-------------------------------------------------"
      grade_input = gets.chomp.to_i
        if !grade_input.between?(0,5)
          while !grade_input.between?(0,5)
            puts "Grade needs to be between 0 and 5. Enter a new grade:"
            grade_input = gets.chomp.to_i
          end
        end
      VisitedPlace.create(place_id: visited_place.id, money_spent: spending_input, user_id: @user.id, grade: grade_input)
    when 3
      puts "Goodbye"
      exit(0)
    else
      puts "Sorry, this is not a valid command.".colorize(:red)
      add_visit
    end
    menu_or_exit
  end

  def update_grade
    puts "-------------------------------------------------"
    puts "Here are all the places you went to:"
    user_all_places = @user.visited_places.map {|visitedplace| visitedplace.place.name}
    user_all_places_names = user_all_places.each {|e| puts e.capitalize}
    puts "Which one do you want to update?"
    puts "-------------------------------------------------"
    place_input = gets.downcase.strip
      # if !user_all_places_names.include?(place_input.capitalize)
      #   while !user_all_places_names.include?(place_input.capitalize)
      #     puts "Please select a name from the list"
      #     place_input = gets.downcase.strip
      #   end
      # end
    place_to_update = Place.find_by(name: place_input)
    visited_place_to_update = VisitedPlace.find_by(place_id: place_to_update.id)
    puts "-------------------------------------------------"
    puts "Current grade for #{place_to_update.name.capitalize} is #{visited_place_to_update.grade}"
    puts "What grade do you want to give it now?"
    puts "(0 for terrible, 5 for amazing)"
    puts "-------------------------------------------------"
    grade_input = gets.chomp.to_i
    visited_place_to_update.grade = grade_input
    menu_or_exit
  end

  def delete_place
    puts "-------------------------------------------------"
    puts "Here are all the places you went to:"
    user_all_places = @user.visited_places.map {|visitedplace| visitedplace.place.name}
    user_all_places_names = user_all_places.each {|e| puts e.capitalize}
    puts "Which one do you want to delete?"
    puts "-------------------------------------------------"
    place_input = gets.downcase.strip
    place_to_delete = Place.find_by(name: place_input)
    visited_place_to_delete = VisitedPlace.find_by(place_id: place_to_delete.id)
    visited_place_to_delete.delete
    puts "-------------------------------------------------"
    puts "#{place_to_delete.name.capitalize} has been removed from your account."
    puts "-------------------------------------------------"
    menu_or_exit
  end

  def see_spending
    puts "-------------------------------------------------".colorize(:blue)
    puts "What do you want to see?".colorize(:blue)
    puts "1. Total spending".colorize(:blue)
    puts "2. Most visited place".colorize(:blue)
    puts "3. Total spent at most visited place".colorize(:blue)
    puts "4. Average amount spent at most visited place".colorize(:blue)
    puts "5. Top 5 most visited places".colorize(:blue)
    puts "6. Place with best grade".colorize(:blue)
    puts "7. Exit".colorize(:blue)
    puts "-------------------------------------------------".colorize(:blue)
      user_input = gets.chomp.to_i
      case user_input
      when 1
        @user.total_spending
      when 2
        @user.most_visited_place
      when 3
        @user.total_spent_at_most_visited_place
      when 4
        @user.average_spent_at_most_visited_place
      when 5
        @user.top_five_most_visited_places
      when 6
        @user.best_grade_place
      when 7
        puts "Goodbye"
        exit(0)
      else
        puts "Sorry, this is not a valid command.".colorize(:red)
        see_spending
      end
      menu_or_exit
    end

    def menu_or_exit
      puts "-------------------------------------------------"
      puts "What do you want to do now?"
      puts "1. Go back to the main menu"
      puts "2. Exit"
      puts "-------------------------------------------------"
      userchoice = gets.chomp.to_i
      case userchoice
      when 1
        main_menu
      when 2
        puts "Goodbye!"
        exit(0)
      end
    end

    def username_validation
      username_input = gets.downcase.strip
      if @user = User.find_by(username: username_input)
        while @user = User.find_by(username: username_input)
          puts "Sorry this username is already taken.\n Choose another one.".colorize(:red)
          username_input = gets.downcase.strip
            while username_input.length > 10
              puts "Sorry this username is too long, max length: 10.\n Choose another one.".colorize(:red)
              username_input = gets.downcase.strip
            end
        end
        @user = User.create(username: username_input)
      elsif username_input.length > 10
        while username_input.length > 10
          puts "Sorry this username is too long, max length: 10.\n Choose another one.".colorize(:red)
          username_input = gets.downcase.strip
        end
        @user = User.create(username: username_input)
      # elsif username_input.empty? || username_input.nil?
      #   while username_input.empty? || username_input.nil?
      #     puts "Username needs to be at least one character.\n Please choose another one.".colorize(:red)
      #     username_input = gets.downcase.strip
      #   end
      #   @user = User.create(username: username_input)
      else
        @user = User.create(username: username_input)
      end
    end

end
