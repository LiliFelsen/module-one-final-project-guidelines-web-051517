
require 'pry'
require 'active_record'

class User < ActiveRecord::Base

  has_many :visited_places
  has_many :places, through: :visited_places

  validates :username, uniqueness: :true


  def total_spending
    total = 0
    self.visited_places.each do |visitedplace|
      total += visitedplace[:money_spent]
    end
    puts total
  end

  def most_visited_place
    puts self.visited_places.max_by(&:visits).place.name
  end

  def total_spent_at_most_visited_place
    puts self.visited_places.max_by(&:visits).money_spent
  end

  def top_five_most_visited_places
    self.visited_places.limit(5).sort_by(&:visits).each do |visitedplace|
      puts visitedplace.place.name
    end
  end

  def average_spent_at_most_visited_place
    total = self.total_spent_at_most_visited_place
    visits = self.visited_places.max_by(&:visits).visits
    puts average = total.to_i / visits.to_i
  end

end
