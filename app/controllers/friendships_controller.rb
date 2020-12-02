class FriendshipsController < ApplicationController
  def create
    new_friend = User.find_by(email: params[:friends_email])
    if new_friend && (current_user.email != params[:friends_email])
      Friendship.create(user_id: current_user.id,
                        friend_id: new_friend.id)
      redirect_to '/user/dashboard'
    elsif current_user.email == params[:friends_email]
      flash[:error] = 'You cannot add yourself as a friend.'
      redirect_to '/user/dashboard'
    else
      flash[:error] = 'User does not exist.'
      redirect_to '/user/dashboard'
    end
  end
end
