class AddAmountEarnedToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :amount_earned, :integer
  end
end
