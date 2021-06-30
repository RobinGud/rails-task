class FixMisstakes < ActiveRecord::Migration[6.1]
  def change
    rename_column :parcels, :weigth, :weight
  end
end
