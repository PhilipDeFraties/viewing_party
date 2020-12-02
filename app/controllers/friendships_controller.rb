class FriendshipsController < ApplicationController
  def create
    new_friend = User.find_by(email: params[:friends_email])
    if current_user.email == params[:friends_email]
      flash[:error] = 'You cannot add yourself as a friend.'
    elsif new_friend
      current_user.create_friendships(current_user.id, new_friend.id)
    else
      flash[:error] = 'User does not exist.'
    end
    redirect_to '/user/dashboard'
  end
end
