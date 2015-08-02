class Api::V1::ParentsController < ApplicationController
  def index
    @parents = User.where(role_id: 1)
  end

  def add_task
    child = User.find_by(id: params[:child_id])
    user = User.find_by(params[:user_id])
    @task = Task.new(to_do: params[:to_do], amount_earned: params[:amount_earned], status: params[:status], user_id: user.id, child_id: child.id)
    if @task.save
      render json: @task.to_json
    else
      head :no_content
    end
  end

  def update_task
    @task = Task.find_by(id: params[:id])
    @task.update(status: params[:status])
    if @task.status == "complete"
      add_to_bank = @task.amount_earned
      current_balance = @task.child.total_balance
      new_balance = current_balance + add_to_bank
      @task.child.update(total_balance: new_balance)
    end
    render json: @task.to_json
  end

  def edit_task
    @task = Task.find_by(id: params[:id])
    @task.update(to_do: params[:to_do], amount_earned: params[:amount_earned])
    if @task.save
      render json: @task.to_json
    end
  end

  def destroy_task
    task_id = params[:id]
    task = Task.find_by(id:task_id)
    task.destroy
    render json: { message: "Successful" }
  end

  def add_reward
    child = User.find_by(id: params[:child_id])
    user = User.find_by(params[:user_id])
    @reward = Reward.new(description: params[:description], amount_cost: params[:amount_cost], image_url: params[:image_url], status: "not bought", user_id: user.id, child_id: child.id)
    if @reward.save
      render json: { message: "Successful" }
    else
      head :no_content
    end
  end

  def update_reward
    @reward = Reward.find_by(id: params[:id])
    @reward.update(status: params[:status])
    if @reward.status == "bought"
      deduct_from_bank = @reward.amount_cost
      current_balance = @reward.child.total_balance
      new_balance = current_balance - deduct_from_bank
      @reward.child.update(total_balance: new_balance)
    end
    render json: @reward.to_json
  end

  def edit_reward
    @reward = Reward.find_by(id: params[:id])
    @reward.update(description: params[:description], amount_cost: params[:amount_cost], image_url: params[:image_url])
    if @reward.save
      render json: @reward.to_json
    end
  end

  def destroy_reward
    reward_id = params[:id]
    reward = Reward.find_by(id:reward_id)
    reward.destroy
    render json: { message: "Successful" }
  end

  def update_interest_rate
    @interest = User.find_by(id: params[:child_id])
    @interest.update(interest_rate: params[:interest_rate])
    if @interest.save
      render json: { message: "Successful" }
    end
  end
end
