class UsersController < ApplicationRecord
  def show
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end
  end
end