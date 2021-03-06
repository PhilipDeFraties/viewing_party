class PartiesController < ApplicationController
  before_action :require_current_user

  def new
    @party = Party.new
  end

  def create
    @movie = Movie.check_db(params[:api_id], movie_params)
    @party = Party.new_party(current_user.id, party_params, @movie.id)
    if @party.save
      send_invites(params[:party_guests])
    else
      flash[:error] = @party.errors.full_messages.to_sentence
      render :new
    end
  end

  def send_invites(friends)
    @party.invite_friends(friends) if friends
    flash[:success] = 'Your Viewing Party was created!'
    redirect_to dashboard_path
  end

  private

  def movie_params
    params.permit(:title, :runtime, :api_id, :logo)
  end

  def party_params
    params.permit(:date, :time, :duration)
  end
end
