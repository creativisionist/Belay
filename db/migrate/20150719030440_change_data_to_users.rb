class ChangeDataToUsers < ActiveRecord::Migration
  def change
    change_column :users, :interest_rate, :decimal, precision: 10, scale: 2
  end
end
