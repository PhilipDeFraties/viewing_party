class PartiesController < ApplicationController
  def new
    @party = Party.new
  end

  def create
    if Movie.find_by(api_id: params[:api_id])
      movie = Movie.find_by(api_id: params[:api_id])
    else
      movie = Movie.create!(movie_params)
    end
    @party = current_user.parties.new(
      date: params[:date],
      time: params[:time],
      duration: params[:duration],
      movie_id: movie.id)
    if @party.save
      invite_friends(params[:party_guests])
      flash[:success] = 'Your Viewing Party was created!'
      redirect_to '/user/dashboard'
    else
      flash[:error] = @party.errors.full_messages.to_sentence
      render :new
    end
  end

  def invite_friends(party_guests)
    party_guests.each do |guest|
      @party.party_guests.create(user_id: guest.to_i)
    end
  end

  private

  def movie_params
    params.permit(:title, :runtime, :api_id, :logo)
  end
end