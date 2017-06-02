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
            puts "Sorry, you do not have an account yet.\n Create a username:".colorize(:red)
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
    puts "1. Add a visit"
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
      when 5 || 'exit' || 'Exit'
        puts "Goodbye!"
        exit(0)
      else
        puts "Sorry, this is not a valid command.".colorize(:red)
        main_menu
      end
      menu_or_exit
  end

  def new_user_menu
    flag_spending = nil
    flag_grade = nil
    puts "-------------------------------------------------"
    puts "Now, you can create a place and grade it!"
    puts "Where did you go?"
    puts "-------------------------------------------------"
    place_input = gets.downcase.strip
    visited_place = Place.find_or_create_by(name: place_input)
    puts "-------------------------------------------------"
    while flag_spending.nil?
    puts "How much did you spend?"
    puts "-------------------------------------------------"
    spending_input = gets.strip.to_i
       if spending_input > 0
         flag_spending = true
       else
         puts "-------------------------------------------------"
         puts "Please enter a valid number.".colorize(:red)
       end
     end
    puts "-------------------------------------------------"
    while flag_grade.nil?
    puts "How was it? (0 for terrible, 5 for amazing)"
    puts "-------------------------------------------------"
    grade_input = gets.strip.to_i
      if grade_input > 0 && grade_input.between?(0,5)
        flag_grade = true
      else
        puts "-------------------------------------------------"
        puts "Grade needs to be between 0 and 5.".colorize(:red)
      end
    end
    VisitedPlace.create(place_id: visited_place.id, money_spent: spending_input, user_id: @user.id, grade: grade_input)
    main_menu
  end

  def add_visit
    puts "-------------------------------------------------"
    puts "You can:"
    puts "1. Add a visit to an existing place"
    puts "2. Create a new place and give it a grade"
    puts "3. Exit"
    puts "-------------------------------------------------"
    userchoice = gets.chomp.to_i
    case userchoice
    when 1
      flag_place = nil
      flag_spending = nil
      puts "-------------------------------------------------"
      puts "Here are all the places you went to:"
      user_all_places = @user.visited_places.map {|visitedplace| visitedplace.place.name}
      user_all_places_names = user_all_places.each {|e| puts e.capitalize}
      while flag_place.nil?
      puts "Which one did you go back to?"
      puts "-------------------------------------------------"
      place_input = gets.downcase.strip
        if user_all_places_names.include? place_input
          visited_place = Place.find_or_create_by(name: place_input)
          flag_place = true
        else
          puts "-------------------------------------------------"
          puts "Please select a name from the list".colorize(:red)
        end
      end
      puts "-------------------------------------------------"
      while flag_spending.nil?
      puts "How much did you spend?"
      puts "-------------------------------------------------"
      spending_input = gets.strip.to_i
         if spending_input > 0
           flag_spending = true
         else
           puts "-------------------------------------------------"
           puts "Please enter a valid number.".colorize(:red)
         end
       end
      new_visit = VisitedPlace.where('place_id = ? AND user_id = ?', visited_place.id, @user.id).first
      current_spending = new_visit.money_spent
      new_spending = current_spending + spending_input
      new_visit.update(money_spent: new_spending)
      current_visit = new_visit.visits
      new_visit_total = current_visit + 1
      new_visit.update(visits: new_visit_total)
    when 2
      flag_spending = nil
      flag_grade = nil
      puts "-------------------------------------------------"
      puts "What is the name of this new place?"
      puts "-------------------------------------------------"
      place_input = gets.downcase.strip
      visited_place = Place.find_or_create_by(name: place_input)
      puts "-------------------------------------------------"
      while flag_spending.nil?
      puts "How much did you spend?"
      puts "-------------------------------------------------"
      spending_input = gets.strip.to_i
         if spending_input > 0
           flag_spending = true
         else
           puts "-------------------------------------------------"
           puts "Please enter a valid number.".colorize(:red)
         end
       end
      puts "-------------------------------------------------"
      while flag_grade.nil?
      puts "How was it? (0 for terrible, 5 for amazing)"
      puts "-------------------------------------------------"
      grade_input = gets.strip.to_i
        if grade_input > 0 && grade_input.between?(0,5)
          flag_grade = true
        else
          puts "-------------------------------------------------"
          puts "Grade needs to be between 0 and 5.".colorize(:red)
        end
      end
      VisitedPlace.create(place_id: visited_place.id, money_spent: spending_input, user_id: @user.id, grade: grade_input)
    when 3 || 'exit' || 'Exit'
      puts "Goodbye!"
      exit(0)
    else
      puts "Sorry, this is not a valid command.".colorize(:red)
      add_visit
    end
    menu_or_exit
  end

  def update_grade
    flag_place = nil
    flag_grade = nil
    puts "-------------------------------------------------"
    puts "Here are all the places you went to:"
    user_all_places = @user.visited_places.map {|visitedplace| visitedplace.place.name}
    user_all_places_names = user_all_places.each {|e| puts e.capitalize}
    while flag_place.nil?
    puts "Which one do you want to update?"
    puts "-------------------------------------------------"
    place_input = gets.downcase.strip
      if user_all_places_names.include? place_input
        place_to_update = Place.find_or_create_by(name: place_input)
        visited_place_to_update = VisitedPlace.where('place_id = ? AND user_id = ?', place_to_update.id, @user.id).first
        flag_place = true
      else
        puts "-------------------------------------------------"
        puts "Please select a name from the list".colorize(:red)
      end
    end
    puts "-------------------------------------------------"
    puts "Current grade for #{place_to_update.name.capitalize} is #{visited_place_to_update.grade}"
    while flag_grade.nil?
    puts "What grade do you want to give it now?\n (0 for terrible, 5 for amazing)"
    puts "-------------------------------------------------"
    grade_input = gets.strip.to_i
      if grade_input > 0 && grade_input.between?(0,5)
        flag_grade = true
      else
        puts "-------------------------------------------------"
        puts "Grade needs to be between 0 and 5.".colorize(:red)
      end
    end
    visited_place_to_update.update(grade: grade_input)
    menu_or_exit
  end

  def delete_place
    flag_place = nil
    puts "-------------------------------------------------"
    puts "Here are all the places you went to:"
    user_all_places = @user.visited_places.map {|visitedplace| visitedplace.place.name}
    user_all_places_names = user_all_places.each {|e| puts e.capitalize}
    while flag_place.nil?
    puts "Which one do you want to delete?"
    puts "-------------------------------------------------"
    place_input = gets.downcase.strip
      if user_all_places_names.include? place_input
        place_to_delete = Place.find_or_create_by(name: place_input)
        visited_place_to_delete = VisitedPlace.find_by(place_id: place_to_delete.id)
        visited_place_to_delete.delete
        puts "-------------------------------------------------"
        puts "#{place_to_delete.name.capitalize} has been removed from your account."
        flag_place = true
      else
        puts "-------------------------------------------------"
        puts "Please select a name from the list".colorize(:red)
      end
    end
    menu_or_exit
  end

  def see_spending
    puts "-------------------------------------------------"
    puts "What do you want to see?"
    puts "1. Total spending"
    puts "2. Most visited place"
    puts "3. Total spent at most visited place"
    puts "4. Average amount spent at most visited place"
    puts "5. Top 5 most visited places"
    puts "6. Place with best grade"
    puts "7. Go back to main menu"
    puts "8. Exit"
    puts "-------------------------------------------------"
      user_input = gets.chomp.to_i
      case user_input
      when 1
        puts "-------------------------------------------------"
        puts "You spent a total of:"
        @user.total_spending
      when 2
        puts "-------------------------------------------------"
        puts "The place you visited most is:"
        @user.most_visited_place
      when 3
        puts "-------------------------------------------------"
        puts "At your most visited place, you spent a total of:"
        @user.total_spent_at_most_visited_place
      when 4
        puts "-------------------------------------------------"
        puts "At your most visited place, on average you spent:"
        @user.average_spent_at_most_visited_place
      when 5
        puts "-------------------------------------------------"
        puts "Your top 5 places are:"
        @user.top_five_most_visited_places
      when 6
        puts "-------------------------------------------------"
        puts "The place with the best grade is:"
        @user.best_grade_place
      when 7
        main_menu
      when 8 || 'exit' || 'Exit'
        puts "Goodbye!"
        exit(0)
      else
        puts "Sorry, this is not a valid command.".colorize(:red)
        see_spending
      end
      sleep(2)
      see_spending
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
      when 2 || 'exit' || 'Exit'
        puts "Goodbye!"
        exit(0)
      end
    end

    def username_validation
      flag_name = nil
      while flag_name.nil?
      username_input = gets.downcase.strip
        if !User.find_by(username: username_input) && username_input.length < 10 && !username_input.empty?
           @user = User.create(username: username_input)
           flag_name = true
        elsif User.find_by(username: username_input)
           puts "Sorry this username is already taken.\n Choose another one.".colorize(:red)
        elsif username_input.length > 10
           puts "Sorry this username is too long, max length: 10.\n Choose another one.".colorize(:red)
        elsif username_input.empty?
           puts "Username needs to be at least one character.\n Choose another one.".colorize(:red)
         end
       end
    end

end

=begin
  - check if spending_amount added when adding visit to existing place
=end
