class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def authenticate_parent!
    if current_user
      if current_user.role.title = "child"
        redirect_to "/tasks"
      end
    end
  end
end
