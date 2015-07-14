class RemoveRewardIdFromTask < ActiveRecord::Migration
  def change
    remove_column :tasks, :reward_id, :integer
  end
end
