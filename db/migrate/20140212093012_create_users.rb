class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.datetime :birthday
      t.integer :position_id
      t.integer :team_id
      t.integer :admin, default: 0
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end
  end
end
