class AddCityToLocation < ActiveRecord::Migration[7.1]

  def change
    add_column :locations, :city, :string
  end

end
