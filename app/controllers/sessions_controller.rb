class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
      flash[:success] = 'You are now logged in'
    else
      flash[:error] = 'Email and/or password is incorrect'
      redirect_to root_path
    end
  end
end
