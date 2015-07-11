class RewardsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_parent!, :except => [:index]

  def index
    @user = User.where(id: params[:user_id])
    @rewards = Reward.all
  end

  def show
    reward_id = params[:id]
    @reward = Reward.find_by(id: reward_id)
  end

  def new
    @reward = Reward.new
  end

  def create
    @reward = Reward.new(description: params[:description], image_url: params[:image_url], amount_cost: params[:amount_cost], user_id: current_user.id)
    if @reward.save
      redirect_to "/rewards"
    else
      render "new"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
