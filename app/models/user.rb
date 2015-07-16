class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role

  has_many :children, class_name: 'User', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'User'

  has_many :tasks
  has_many :child_tasks, class_name: 'Task', foreign_key: 'child_id'

  has_many :rewards
  has_many :child_rewards, class_name: 'Reward', foreign_key: 'child_id'

  has_many :user_interests
  has_many :child_user_interests, class_name: 'UserInterest', foreign_key: 'child_id'
end
