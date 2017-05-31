class CLI

  puts "Welcome to your Budgeting App!"

  def user
    puts "Sign in with your name"
    name_input = gets.downcase.strip
    puts "and username"
    username_input = gets.downcase.strip
    user = User.find_or_create_by(username: username_input, name: name_input)
  end

  def menu
    puts "What do you want to do?"
    puts "1 to add a new visit or 2 to see your spending status"
    userchoice = gets.chomp.to_i
      case userchoice
      when 1
        add_visit
        menu_or_exit
      when 2
        see_spending
        menu_or_exit
      else
        puts "This is not a valid command."
      end
  end

  def add_visit
    puts "1 to add a visit to an existing place or 2 to create a new place"
    userchoice = gets.chomp.to_i
    case userchoice
    when 1
      puts "Where did you go?"
      place_input = gets.downcase.strip
      visited_place = Place.find_by(name: place_input)
      puts "How much did you spend?"
      spending_input = gets.chomp.to_i
      new_visit = VisitedPlace.find_by(place: visited_place.id)
      new_visit.money_spent += spending_input
      new_visit.visits += 1
    when 2
      puts "What is the name of the new place?"
      place_input = gets.downcase.strip
      visited_place = Place.create(name: place_input)
      puts "How much did you spend?"
      spending_input = gets.chomp.to_i
      VisitedPlace.create(place: visited_place.id, money_spent: spending_input, user: user)
    else
      puts "This is not a valid command."
    end
  end

  def see_spending
    puts "Select one of below options:"
    puts "1 to see total spending"
    puts "2 to see most visited place"
    puts "3 to see total spent at most visited place"
    puts "4 to see average amount spent at most visited place"
    puts "5 to see top 5 most visited places"
      user_input = gets.chomp.to_i
      case user_input
      when 1
        user.total_spending
      when 2
        user.most_visited_place
      when 3
        user.total_spent_at_most_visited_place
      when 4
        user.average_spent_at_most_visited_place
      when 5
        user.top_five_most_visited_places
      else
        puts "This is not a valid command."
      end
    end

    def menu_or_exit
      puts "What do you want to do now? You can exit or go back to the menu"
      userchoice = gets.downcase.strip
      case userchoice
      when 'exit'
        puts "Goodbye!"
      when userchoice.include? 'menu'
        menu
      end
    end

end
