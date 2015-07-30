class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  helper_method :user_is_child?

  private

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
