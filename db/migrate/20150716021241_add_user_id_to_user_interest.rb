class AddUserIdToUserInterest < ActiveRecord::Migration
  def change
    add_column :user_interests, :user_id, :integer
  end
end
