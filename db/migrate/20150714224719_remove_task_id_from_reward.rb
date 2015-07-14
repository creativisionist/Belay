class RemoveTaskIdFromReward < ActiveRecord::Migration
  def change
    remove_column :rewards, :task_id, :integer
  end
end
