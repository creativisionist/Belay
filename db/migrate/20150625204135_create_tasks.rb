class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :to_do
      t.integer :user_id
      t.integer :reward_id

      t.timestamps null: false
    end
  end
end
