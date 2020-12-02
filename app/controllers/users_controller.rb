class UsersController < ApplicationRecord
  def show
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
    
    @users = User.all
    @search_results = []
    if params[:search] != '' && !params[:search].nil?
      @search_results = @users.where('lower(name) like ?', "%#{params[:search]}%".downcase)
    end
  end
end