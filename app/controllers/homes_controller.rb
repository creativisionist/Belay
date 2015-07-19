class HomesController < ApplicationController
  def index
    if user_is_child?
      redirect_to "/child_dashboard"
    else
      redirect_to "/parent_dashboard"
    end
  end
end
