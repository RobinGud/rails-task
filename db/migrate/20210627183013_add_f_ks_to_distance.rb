class AddFKsToDistance < ActiveRecord::Migration[6.1]
  def change
    add_column :distances, :from_city_id, :bigint
    add_column :distances, :to_city_id, :bigint

    add_foreign_key :distances, :cities, column: :from_city_id
    add_foreign_key :distances, :cities, column: :to_city_id
    
    add_column :parcels, :distance_id, :bigint

    add_foreign_key :parcels, :distances, column: :distance_id

    remove_column :parcels, :from_city_id
    remove_column :parcels, :to_city_id
  end
end
