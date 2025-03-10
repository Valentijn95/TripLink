class CreateUserInterests < ActiveRecord::Migration[7.1]
  def change
    create_table :user_interests do |t|
      t.references :interest, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
