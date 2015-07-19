class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_parent!, :except => [:child_dashboard, :savings, :update_status]
  require 'date'

  def child_dashboard
    if user_is_child?
      @tasks = current_user.child_tasks.where(status: "incomplete")
      @current_balance = current_user.total_balance
      @current_investments = current_user.child_user_interests.where.not(withdrawl_status: "paid")

      @array_of_remains = []
      @array_of_pasts = []
      @array_of_dates = []
      @total_investments = 0
      @test
      @current_investments.each do |investment|
        created = Date.parse(investment.created_at.to_s)
        @array_of_dates.push(created)
        duration = investment.duration.to_i
        now = Date.today
        time_passed = now - created
        if time_passed > duration
          time_passed = duration
          if investment.withdrawl_status == "accruing"
            investment.update(withdrawl_status: "complete")
          end
        end
        @array_of_pasts.push(time_passed.to_i)
        time_remaining = duration - time_passed
        @array_of_remains.push(time_remaining.to_i)
        r =  investment.interest_rate.to_f
        p =  investment.money_invested.to_f
        t =  (time_passed.to_f / 360).to_f
        a = (p * (1 + (r * t))).to_f
        investment.update(last_investment_balance: a)
        # Uncomment to fix final balance values in database
        # total = (p * (1 + (r * duration/365))).to_f
        # investment.update(final_balance: total)
        @total_investments += a
      end
      p @test
      p @total_investments
      @investments_and_balance = @total_investments + @current_balance
      @current_interest = current_user.interest_rate
    else
      redirect_to "/parent_dashboard"
    end
  end

  def savings
    if user_is_child?
      if params[:money_invested].to_f <= current_user.total_balance
        @savings = UserInterest.new(interest_rate: current_user.interest_rate, money_invested: params[:money_invested], last_investment_balance: params[:money_invested], final_balance: params[:money_invested], withdrawl_status: "accruing", child_id: current_user.id, duration: params[:duration])
        if @savings.save
          subtract_from_bank = @savings.money_invested
          current_balance = current_user.total_balance
          new_balance = current_balance - subtract_from_bank
          total = (@savings.money_invested * (1 + (@savings.interest_rate * @savings.duration/360))).to_f
          @savings.update(final_balance: total)
          @current_user.update(total_balance: new_balance)
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

  def update_status
    if user_is_child?
      investment_id = params[:id]
      @investment = UserInterest.find_by(id: investment_id)
      @investment.update(withdrawl_status: params[:withdrawl_status])
      if @investment.withdrawl_status == "paid"
        deposit_to_bank = @investment.final_balance.to_i
        current_balance = current_user.total_balance
        new_balance = current_balance + deposit_to_bank
        @current_user.update(total_balance: new_balance)
      end
      redirect_to "/child_dashboard"
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
