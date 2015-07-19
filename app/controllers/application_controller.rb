class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :user_is_child?
  
  private

  # def authenticate_user!
  #   unless user_signed_in?
  #     redirect_to "/users/sign_in"
  #   end
  # end

  # def after_sign_in_path_for(resource)
  #   if user_is_child?
  #     "/child_dashboard"
  #   else
  #     "/parent_dashboard"
  #   end
  # end

  def user_is_child?
    current_user.parent_id
  end

  def authenticate_parent!
    if current_user
      if current_user.role.title == "child"
        redirect_to "/child_dashboard"
      end
    end
  end
end
