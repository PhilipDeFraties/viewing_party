class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_current_user
<<<<<<< HEAD
    unless current_user
      flash[:error] = 'Please login.'
      redirect_to root_path
    end
=======
    return if current_user

    flash[:error] = 'Please login.'
    redirect_to root_path
>>>>>>> 51d09e3a843e5fc567b92a8bc472b46f8c301c7e
  end
end
