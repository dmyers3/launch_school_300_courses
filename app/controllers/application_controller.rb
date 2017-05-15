class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :logged_in?, :current_user
  
  def current_user
    @current_user ||= session[:user_id] ? User.find(session[:user_id]) : nil
  end
  
  def logged_in?
    !!current_user
  end
  
  def redirect_logged_out
    if !logged_in?
      flash[:error] = "You must be logged in to do that."
      redirect_to root_path
    end
  end
  
  def require_admin
    access_denied unless logged_in? && current_user.admin?
  end
  
  def require_creator_or_admin(obj)
    access_denied unless logged_in? && (obj.creator == current_user || current_user.admin?)
  end
  
  def access_denied
    flash[:error] = "You can't do that."
    redirect_to :back
  end
  
  
  
end
