class UserInterest < ActiveRecord::Base
  belongs_to :user
  belongs_to :child, class_name: 'User', foreign_key: 'child_id'
end
