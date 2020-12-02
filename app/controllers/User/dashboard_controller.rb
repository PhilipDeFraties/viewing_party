class User::DashboardController < ApplicationController
  before_action :require_current_user

  def show;end
end
