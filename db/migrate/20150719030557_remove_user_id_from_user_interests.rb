class RemoveUserIdFromUserInterests < ActiveRecord::Migration
  def change
    remove_column :user_interests, :user_id, :integer
  end
end
