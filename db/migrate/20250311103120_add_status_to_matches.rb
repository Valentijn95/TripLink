class AddStatusToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :status, :string
  end
end
