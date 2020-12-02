class FriendshipsController < ApplicationController
  def create
    new_friend = User.find_by(email: params[:friends_email])
    if current_user.email == params[:friends_email]
      flash[:error] = 'You cannot add yourself as a friend.'
<<<<<<< HEAD
      redirect_to '/user/dashboard'
=======
    elsif new_friend
      current_user.create_friendships(current_user.id, new_friend.id)
>>>>>>> 51d09e3a843e5fc567b92a8bc472b46f8c301c7e
    else
      flash[:error] = 'User does not exist.'
    end
    redirect_to '/user/dashboard'
  end
end
