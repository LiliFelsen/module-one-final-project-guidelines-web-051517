
require 'pry'
require 'active_record'



class User < ActiveRecord::Base

  has_many :visited_places
  has_many :places, through: :visited_places

  def add_visit(place, money_spent)
    VisitedPlace.create(money_spent: money_spent, user: self, visits: 1, place: place)
  end

end


# def add_visit(place, money_spent)
#   Places.all.find do |visitedplace|
#     visitedplace.name == place
#   end
