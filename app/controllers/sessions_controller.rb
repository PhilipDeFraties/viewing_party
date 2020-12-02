class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if !user
      flash[:error] = 'Email and/or password is incorrect'
      redirect_to '/'
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/user/dashboard'
      flash[:success] = 'You are now logged in'
    else
      flash[:error] = 'Email and/or password is incorrect'
      redirect_to '/'
    end
  end
end
