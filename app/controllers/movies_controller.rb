class MoviesController < ApplicationController
  def show
    @results = MovieFacade.details(params[:movie_id])
  end

  def top40
    @top40 = MovieFacade.top40
    respond_to do |format|
      format.html { render :top40 }
      format.js { render :top40 }
    end
  end

  def search
    @results = MovieFacade.search(params[:search])
    respond_to do |format|
      format.html { render :search }
      format.js { render :search }
    end
    flash[:error] = 'No movies matched your search.' if @results.empty?
  end
end
