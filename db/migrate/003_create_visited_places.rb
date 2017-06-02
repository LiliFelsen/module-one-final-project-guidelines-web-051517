
class CreateVisitedPlaces < ActiveRecord::Migration[4.2]

  def change
    create_table :visited_places do |t|
      t.integer :money_spent
      t.integer :visits, :default => 1
      t.integer :grade
      t.references :user
      t.references :place
    end
  end
end
