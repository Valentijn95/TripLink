class AddNameToLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :name, :string
  end
end
