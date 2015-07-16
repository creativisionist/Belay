class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_parent!, :except => [:index, :update_status]

  def index
    if user_is_child?
      @tasks = current_user.child_tasks.where(status: "incomplete")
    else
      @tasks = current_user.tasks.where(status: ["pending","incomplete"])
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
    @task = Task.new(to_do: params[:to_do], amount_earned: params[:amount_earned], status: "incomplete", user_id: current_user.id, child_id: params[:child])
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

  def update_status
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    @task.update(status: params[:status])
    #flash message
    if @task.status == "complete"
      add_to_bank = @task.amount_earned
      current_balance = @task.child.total_balance
      new_balance = current_balance + add_to_bank
      @task.child.update(total_balance: new_balance)
    end
    redirect_to "/tasks"
  end

  def destroy
    task_id = params[:id]
    task = Task.find_by(id:task_id)
    task.destroy
    redirect_to "/tasks"
  end
end
