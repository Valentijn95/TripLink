class AddDescriptionToLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :description , :text
  end
end
