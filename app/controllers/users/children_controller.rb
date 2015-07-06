class Users::ChildrenController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(child_params)
    @user.role_id = 2
    @user.parent_id = params[:parent_id]
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  private

  def child_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
