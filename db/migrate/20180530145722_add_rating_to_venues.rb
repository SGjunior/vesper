class AddRatingToVenues < ActiveRecord::Migration[5.2]
  def change
    add_column :venues, :rating, :float
  end
end
