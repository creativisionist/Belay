class CreateUserInterests < ActiveRecord::Migration
  def change
    create_table :user_interests do |t|
      t.float :interest_rate
      t.float :money_invested
      t.float :last_investment_balance
      t.float :final_balance
      t.string :withdrawl_status
      t.integer :child_id

      t.timestamps null: false
    end
  end
end
