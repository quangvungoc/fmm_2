class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.integer :action_id
      t.integer :user_id
      t.datetime :time

      t.timestamps
    end
  end
end
