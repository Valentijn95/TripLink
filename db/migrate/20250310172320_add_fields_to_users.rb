class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :tourist_description, :text
    add_column :users, :guide_description, :text
    add_column :users, :rate, :integer
    add_column :users, :short_description, :string
    add_column :users, :guide, :boolean
  end
end
