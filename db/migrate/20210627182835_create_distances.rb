class CreateDistances < ActiveRecord::Migration[6.1]
  def change
    create_table :distances do |t|
      t.float :distance

      t.timestamps
    end
  end
end
