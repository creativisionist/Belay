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
end
