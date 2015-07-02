class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.string :description
      t.string :image_url
      t.integer :amount_cost
      t.integer :user_id
      # t.integer :task_id

      t.timestamps
    end
  end
end
