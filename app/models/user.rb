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

  def incomplete_tasks
    child_tasks.where(status: "incomplete")
  end

  def child_tasks_needing_approval
    child_tasks.where(status: "pending")
  end

  def child_rewards_needing_approval
    child_rewards.where(status: "pending")
  end

  def rewards_not_bought
    child_rewards.where(status: "not bought")
  end

  def interests_not_paid
    child_user_interests.where.not(withdrawl_status: "paid")
  end

  def paid_interests
    child_user_interests.where(withdrawl_status: "paid")
  end

  def childrens_incomplete_tasks
    tasks.where(status: "incomplete")
  end

  def tasks_needing_approval
    tasks.where(status: "pending")
  end

  def rewards_needing_approval
    rewards.where(status: "pending")
  end
end
