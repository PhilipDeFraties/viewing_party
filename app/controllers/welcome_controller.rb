class WelcomeController < ApplicationController
  def index
    redirect_to '/user/dashboard' if current_user
  end
end
