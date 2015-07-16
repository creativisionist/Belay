class AddInterestRateToUser < ActiveRecord::Migration
  def change
    add_column :users, :interest_rate, :float
  end
end
