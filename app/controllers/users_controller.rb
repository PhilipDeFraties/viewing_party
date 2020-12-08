class UsersController < ApplicationController
  def new
    if current_user
      flash[:notice] = 'You are already registerd.'
      redirect_to dashboard_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.username}!"
      redirect_to dashboard_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = 'Profile has been updated!'
      redirect_to dashboard_path
    else
      flash[:error] = current_user.errors.full_messages.to_sentence
      redirect_to :edit_user
    end
  end

  def edit; end

  def change_password; end

  def update_password
    if current_user.update(user_params)
      binding.
      flash[:notice] = 'Password changed!'
      redirect_to dashboard_path
    else
      flash[:error] = current_user.errors.full_messages.to_sentence
      redirect_to :edit_user
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
