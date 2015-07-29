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
end
