class MoviesController < ApplicationController
  before_action :require_current_user

  def show
    @results = MovieFacade.details(params[:movie_id])
    @trailer = MovieFacade.trailer(params[:movie_id])
  end

  def top40
    @top40 = MovieFacade.top40
  end

  def search
    @results = MovieFacade.search(params[:search])
    flash[:error] = 'No movies matched your search.' if @results.empty?
  end
end
