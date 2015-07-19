class ChangeDataToUserInterests < ActiveRecord::Migration
  def change
    change_column :user_interests, :interest_rate, :decimal, precision: 10, scale: 2
    change_column :user_interests, :money_invested, :decimal, precision: 30, scale: 2
    change_column :user_interests, :last_investment_balance, :decimal, precision: 30, scale: 2
    change_column :user_interests, :final_balance, :decimal, precision: 30, scale: 2
  end
end
