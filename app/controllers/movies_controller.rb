class MoviesController < ApplicationController
  def top40; end

  def search
    search = params[:search]

    redirect_to "/movies/results?q=#{search.downcase}"
  end

  def search_results; end
end
