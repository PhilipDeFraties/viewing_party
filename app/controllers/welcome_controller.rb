class WelcomeController < ApplicationController
  def index
    @user = User.new
    redirect_to dashboard_path if current_user
  end
end
