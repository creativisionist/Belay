class TasksController < ApplicationController
  before_action :authenticate_parent!, :except => [:index]

  def index
    @user = User.where(id: params[:user_id])
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(to_do: params[:to_do], user_id: params[:user_id], reward_id: params[:reward_id], amount_earned: params[:amount_earned], status: params[:status])
    if @task.save
      #flash message
      redirect_to "/tasks"
    else
      render "new"
    end
  end
end
