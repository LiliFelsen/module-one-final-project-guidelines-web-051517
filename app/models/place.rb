
class Place < ActiveRecord::Base

  has_many :visited_places
  has_many :users, through: :visited_places

end
