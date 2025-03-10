class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :address
      t.string :lng
      t.string :lat

      t.timestamps
    end
  end
end
