class RewardsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_parent!, :except => [:index]

  def index
    @user = User.where(id: params[:user_id])
    if user_is_child?
      @rewards = current_user.child_rewards
    else
      @rewards = current_user.rewards
    end
  end

  def show
    reward_id = params[:id]
    @reward = Reward.find_by(id: reward_id)
  end

  def new
    @reward = Reward.new
  end

  def create
    @reward = Reward.new(description: params[:description], image_url: params[:image_url], amount_cost: params[:amount_cost], user_id: current_user.id, child_id: params[:child])
    if @reward.save
      redirect_to "/rewards"
    else
      render "new"
    end
  end

  def edit
    reward_id = params[:id]
    @reward = Reward.find_by(id: reward_id)
  end

  def update
    reward_id = params[:id]
    @reward = Reward.find_by(id: reward_id)
    @reward.update(description: params[:description], image_url: params[:image_url], amount_cost: params[:amount_cost], user_id: current_user.id)
    #flash message
    redirect_to "/rewards"
  end

  def update_status

  end

  def destroy
    reward_id = params[:id]
    reward = Reward.find_by(id:reward_id)
    reward.destroy
    redirect_to "/rewards"
  end
end
