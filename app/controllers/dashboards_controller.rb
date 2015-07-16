class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_parent!, :except => [:child_dashboard, :savings]
  
  def child_dashboard
    if user_is_child?
      @tasks = current_user.child_tasks.where(status: "incomplete")
      @current_balance = current_user.total_balance
      @current_investments = current_user.child_user_interests.where(withdrawl_status: "accruing")
      @total_investments = UserInterest.sum(:last_investment_balance, :conditions => { child_id: current_user.id, withdrawl_status: "accruing"})
      # @total_investments = @investments.inject(0){:+}
      @investments_and_balance = @total_investments + @current_balance
      @current_interest = current_user.interest_rate
    else
      redirect_to "/parent_dashboard"
    end
  end

  def savings
    if user_is_child?
      if params[:money_invested].to_f <= current_user.total_balance
        @savings = UserInterest.new(interest_rate: current_user.interest_rate, money_invested: params[:money_invested], last_investment_balance: params[:money_invested], final_balance: params[:money_invested], withdrawl_status: "accruing", child_id: current_user.id)
        if @savings.save
          #calculate out of total_balance
          redirect_to "/child_dashboard"
        end
      else
        #flash message
        redirect_to "/child_dashboard"
      end
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
    if @interest.save
      #flash message
      redirect_to "/parent_dashboard"
    end
  end
end
