class AddChildIdToReward < ActiveRecord::Migration
  def change
    add_column :rewards, :child_id, :integer
  end
end
