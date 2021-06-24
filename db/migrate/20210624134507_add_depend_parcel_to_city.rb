class AddDependParcelToCity < ActiveRecord::Migration[6.1]
  def change
    add_column :parcels, :from_city_id, :bigint
    add_column :parcels, :to_city_id, :bigint

    add_foreign_key :parcels, :cities, column: :from_city_id
    add_foreign_key :parcels, :cities, column: :to_city_id
  end
end
