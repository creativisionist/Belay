class Api::V1::ChildrenController < ApplicationController
  def index
    @children = User.where(role_id: 2)
    @children.each do |child|
      child.interests_not_paid.each do |investment|
        if investment.withdrawl_status == "accruing" && investment.days_passed >= investment.duration
          investment.update(withdrawl_status: "complete")
        end
      end
    end  
  end

  def update
    investment_id = params[:id]
    @investment = UserInterest.find_by(id: investment_id)
    user = User.find(@investment.child_id)
    @investment.update(withdrawl_status: params[:withdrawl_status])
    if @investment.withdrawl_status == "paid"
      deposit_to_bank = @investment.final_balance.to_d
      current_balance = user.total_balance
      new_balance = current_balance + deposit_to_bank
      user.update(total_balance: new_balance)
    end

    head :no_content
  end

  def create
    user = User.find(params[:child_id])
    if params[:money_invested].to_f <= user.total_balance
      @savings = UserInterest.new(interest_rate: user.interest_rate, money_invested: params[:money_invested], last_investment_balance: params[:money_invested], final_balance: params[:money_invested], withdrawl_status: "accruing", child_id: user.id, duration: params[:duration])
      if @savings.save
        subtract_from_bank = @savings.money_invested
        current_balance = user.total_balance
        new_balance = current_balance - subtract_from_bank
        total = (@savings.money_invested * (1 + (@savings.interest_rate * @savings.duration/360)))
        @savings.update(final_balance: total)
        user.update(total_balance: new_balance)
      end
    end

    redirect_to "/api/v1/children.json"
  end
end
