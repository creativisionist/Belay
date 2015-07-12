class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_parent!, :except => [:index]

  def index
    @user = User.where(id: params[:user_id], status: "incomplete")
    if user_is_child?
      @tasks = current_user.child_tasks
    else
      @tasks = current_user.tasks
    end
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(to_do: params[:to_do], reward_id: params[:reward_id], amount_earned: params[:amount_earned], status: params[:status], user_id: current_user.id, child_id: params[:child_id])
    #add numericality
    if @task.save
      #flash message
      redirect_to "/tasks"
    else
      render "new"
    end
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
  end

  def update
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    @task.update(to_do: params[:to_do], reward_id: params[:reward_id], amount_earned: params[:amount_earned], status: params[:status], user_id: current_user.id)
    #flash message
    redirect_to "/tasks"
  end

  def destroy
    task_id = params[:id]
    task = Task.find_by(id:task_id)
    task.destroy
    redirect_to "/tasks"
  end
end
