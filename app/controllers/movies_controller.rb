class MoviesController < ApplicationController
<<<<<<< HEAD
  def top40; end

  def search
    search = params[:search]

    redirect_to "/movies/results?q=#{search.downcase}"
  end

  def search_results; end
=======
  def search; end
>>>>>>> 51d09e3a843e5fc567b92a8bc472b46f8c301c7e
end
