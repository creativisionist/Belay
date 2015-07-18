class AddDurationToUserInterest < ActiveRecord::Migration
  def change
    add_column :user_interests, :duration, :integer
  end
end
