class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_parent!, :except => [:child_dashboard]
  
  def child_dashboard
    if user_is_child?
      @user = User.where(id: params[:user_id])
      @tasks = current_user.child_tasks.where(status: "incomplete")
      @current_balance = current_user.total_balance
    else
      redirect_to "/parent_dashboard"
    end
  end

  def parent_dashboard
  end
end
