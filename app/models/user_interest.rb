class UserInterest < ActiveRecord::Base
  belongs_to :user
  belongs_to :child, class_name: 'User', foreign_key: 'child_id'

  def investment_date
    Date.parse(created_at.to_s)
  end

  def days_passed
    if (Date.current - investment_date).to_i >= duration
      return duration
    else
      return (Date.current - investment_date).to_i
    end
  end

  def days_remaining
    if (duration.to_f - (Date.current - investment_date).to_i) <= 0
      return 0
    else
      return (duration.to_f - (Date.current - investment_date).to_i)
    end
  end

  def investment_balance_to_date
    time = days_passed.to_f / 360
    (money_invested * (1 + (interest_rate * time))).round(2)
  end
end
