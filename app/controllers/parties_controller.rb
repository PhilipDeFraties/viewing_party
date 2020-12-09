class PartiesController < ApplicationController
  def new
    @party = Party.new
  end

  def create
    @movie = add_movie(params[:api_id])
    @party = Party.new_party(current_user.id, party_params, @movie.id)
    if @party.save
      send_invites(params[:party_guests])
    else
      flash[:error] = @party.errors.full_messages.to_sentence
      render :new
    end
  end

  def send_invites(friends)
    if friends
      @party.invite_friends(friends)
      flash[:success] = 'Your Viewing Party was created!'
    end
    redirect_to dashboard_path
  end


  private

  def add_movie(api_id)
    @movie = Movie.find_by(api_id: api_id) || Movie.create!(movie_params)
  end
  
  def movie_params
    params.permit(:title, :runtime, :api_id, :logo)
  end

  def party_params
    params.permit(:date, :time, :duration)
  end
end
