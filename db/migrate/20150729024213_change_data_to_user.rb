class ChangeDataToUser < ActiveRecord::Migration
  def change
    change_column :users, :total_balance, :decimal, precision: 10, scale: 2
  end
end
