class AddCityLngLatToLocation < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :city_lng, :float
    add_column :locations, :city_lat, :float
  end
end
