class PartiesController < ApplicationController
  before_action :require_current_user

  def new
    @party = Party.new
  end

  def create
    add_movie(params[:api_id])
    @party = current_user.parties.new(
      date: params[:date],
      time: params[:time],
      duration: params[:duration],
      movie_id: @movie.id
    )
    if @party.save
      @party.invite_friends(params[:party_guests])
      flash[:success] = 'Your Viewing Party was created!'
      redirect_to dashboard_path
    else
      flash[:error] = @party.errors.full_messages.to_sentence
      render :new
    end
  end

  def add_movie(api_id)
    @movie = Movie.find_by(api_id: api_id) || Movie.create!(movie_params)
  end

  private

  def movie_params
    params.permit(:title, :runtime, :api_id, :logo)
  end
end
