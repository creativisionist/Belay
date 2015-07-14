class AddStatusToReward < ActiveRecord::Migration
  def change
    add_column :rewards, :status, :string
  end
end
