class TasksController < ApplicationController

  def index
    user = User.where(id: params[:user_id])
    if user.role = 'child'
      @tasks = Task.where(user_id: params[:user_id])
    elsif user.role = 'parent'
      @tasks = user.children.each.child.tasks
  end

  def new
    @task = Task.new
  end

  def create

  end

  def show

  end

  def edit
  end

  def update
  end

  def destroy
  end
end
