class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :desc
      t.integer :leader_id

      t.timestamps
    end
  end
end
