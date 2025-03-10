class CreateGuideLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :guide_locations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
