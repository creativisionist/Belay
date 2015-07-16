class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_parent!, :except => [:child_dashboard]
  
  def child_dashboard
    if user_is_child?
      @tasks = current_user.child_tasks.where(status: "incomplete")
      @current_balance = current_user.total_balance
    else
      redirect_to "/parent_dashboard"
    end
  end

  def parent_dashboard
    @tasks_todo = current_user.tasks.where(status: ["incomplete"])
    @tasks_pending = current_user.tasks.where(status: ["pending"])
    @rewards_pending = current_user.rewards.where(status: ["pending"])
  end

  def update_interest
    parent_id = params[:child]
    @interest = User.find_by(id: parent_id)
    @interest.update(interest_rate: params[:interest_rate], parent_id: current_user.id)
    #call child from user table for interest
    if @interest.save
      #flash message
      redirect_to "/parent_dashboard"
    end
  end
end
