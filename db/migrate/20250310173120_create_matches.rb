class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.references :guide, null: false, foreign_key: { to_table: :users }
      t.references :tourist, null: false, foreign_key: { to_table: :users }
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
