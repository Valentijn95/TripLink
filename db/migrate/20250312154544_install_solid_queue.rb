class InstallSolidQueue < ActiveRecord::Migration[7.1]
  def change
    create_table :solid_queues do |t|
      t.string :queue_name
      t.integer :priority, default: 0
      t.datetime :enqueued_at
      t.timestamps
    end
  end
end
