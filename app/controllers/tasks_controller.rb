class TasksController < ApplicationController
before_action :authenticate_parent!, :except => [:index]
  
  def index
    user = User.where(id: params[:user_id])
    
  end

  # def new
  #   @task = Task.new
  # end
end