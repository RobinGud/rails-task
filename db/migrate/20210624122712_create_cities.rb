class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :wikidata_id
      t.float :lat
      t.float :lon
      
      t.timestamps
    end
  end
end
