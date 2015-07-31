class Api::V1::ParentsController < ApplicationController
  def index
    @parents = User.where(role_id: 1)
  end

  def update_task
    @task = Task.find_by(id: params[:id])
    @task.update(status: params[:status])

    head :no_content
  end

  def update_interest_rate
    @interest = User.find_by(id: params[:child_id])
    @interest.update(interest_rate: params[:interest_rate])
    if @interest.save
      render json: {message: "Successful"}
    end
  end
end
