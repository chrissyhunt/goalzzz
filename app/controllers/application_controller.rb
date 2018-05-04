class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :authorized?

  private

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access these pages."
      redirect_to root_path
    end
  end

  def authorized?(obj)
    if obj.class.name.downcase == "user"
      obj.id == current_user.id
    else
      obj.user == current_user
    end
  end
end
