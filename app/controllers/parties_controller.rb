class PartiesController < ApplicationController
  def new
    @party = Party.new
  end

  def create
    require 'pry'; binding.pry
    @party = Party.new(party_params)
    if @party.save
      if Movie.find_by(api_id: params[:api_id])
        flash[:success] = 'Your Viewing Party has been Created'
        redirect_to '/user/dashboard'
      else
          Movie.create(movie_params)
          flash[:success] = 'Your Viewing Party has been Created'
          redirect_to '/user/dashboard'
      end
    else
      flash[:error] = @party.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  # def party_params
  #   params.require(:party).permit(:user_id, :movie_id, :date, :time, :duration)
  # end

  # def movie_params
  #   params.permit(:title, :runtime, :api_id, :logo)
  # end
end