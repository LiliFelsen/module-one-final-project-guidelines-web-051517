
require 'pry'
require 'active_record'

class User < ActiveRecord::Base
  validates_presence_of :username
  validates_length_of :username, :maximum => 10
  validates_uniqueness_of :username

  has_many :visited_places
  has_many :places, through: :visited_places

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

  def average_spent_at_most_visited_place
    total = self.total_spent_at_most_visited_place
    visits = self.visited_places.max_by(&:visits).visits
    puts average = total.to_i / visits.to_i
  end

  def top_five_most_visited_places
    self.visited_places.limit(5).sort_by(&:visits).each do |visitedplace|
      puts visitedplace.place.name
    end
  end

  def best_grade_place
    puts self.visited_places.max_by(&:grade).place.name
  end

end
