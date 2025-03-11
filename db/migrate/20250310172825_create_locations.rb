class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :address
      t.float :lng
      t.float :lat

      t.timestamps
    end
  end
end
