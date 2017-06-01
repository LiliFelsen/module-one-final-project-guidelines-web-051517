class CLI

  attr_accessor :user

  def initialize
    @user = nil
  end

  def sign_in
    puts "Please sign in with your name:"
    name_input = gets.downcase.strip
    puts "and username:"
    username_input = gets.downcase.strip
    @user = User.find_or_create_by(username: username_input, name: name_input)
    menu
  end

  def menu
    puts "What do you want to do?"
    puts "1. Add a new visit"
    puts "2. See your spending status"
    userchoice = gets.chomp.to_i
      case userchoice
      when 1
        add_visit
      when 2
        see_spending
      else
        puts "Sorry, this is not a valid command."
      end
  end

  def add_visit
    puts "Do you want to"
    puts "1. Add a new visit to an existing place"
    puts "2. Create a new place and visit"
    userchoice = gets.chomp.to_i
    case userchoice
    when 1
      puts "Where did you go?"
      place_input = gets.downcase.strip
      visited_place = Place.find_or_create_by(name: place_input)
      puts "How much did you spend?"
      spending_input = gets.chomp.to_i
      new_visit = VisitedPlace.find_by(place_id: visited_place.id)
      new_visit.money_spent += spending_input
      new_visit.visits += 1
    when 2
      puts "What is the name of the new place?"
      place_input = gets.downcase.strip
      visited_place = Place.create(name: place_input)
      puts "How much did you spend?"
      spending_input = gets.chomp.to_i
      VisitedPlace.create(place_id: visited_place.id, money_spent: spending_input, user_id: @user.id)
    else
      puts "Sorry, this is not a valid command."
    end
    menu_or_exit
  end

  def see_spending
    puts "What do you want to see?"
    puts "1. Total spending"
    puts "2. Most visited place"
    puts "3. Total spent at most visited place"
    puts "4. Average amount spent at most visited place"
    puts "5. Top 5 most visited places"
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
      else
        puts "Sorry, this is not a valid command."
      end
      menu_or_exit
  end

    def menu_or_exit
      puts "What do you want to do now?"
      puts "1. Go back to the main menu"
      puts "2. Exit"
      userchoice = gets.chomp.to_i
      case userchoice
      when 1
        menu
      when 2
        puts "Goodbye!"
      end
    end

end
