class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    @parent = User.new(sign_up_params)
    @parent.role_id = 1
    if @parent.save
      redirect_to new_users_child_path(:parent_id => @parent.id), :notice => 'New Parent has been added'
    else
      super
      # render :action => 'new'
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :email, :password, :password_confirmation)
  end
end
