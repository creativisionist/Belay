class AddTotalBalanceToUser < ActiveRecord::Migration
  def change
    add_column :users, :total_balance, :integer
  end
end
