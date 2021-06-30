class CreateParcels < ActiveRecord::Migration[6.1]
  def change
    create_table :parcels do |t|
      t.float :volume
      t.float :weigth
      t.float :price

      t.timestamps
    end
  end
end
