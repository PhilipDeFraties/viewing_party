class MoviesController < ApplicationController
  def show
    
  end

  def top40
    conn = Faraday.new("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV["THE_MOVIE_DB_API"]}&language=en-US")
    response = conn.get
    json = JSON.parse(response.body, symbolize_names: true)
    
    conn2 = Faraday.new("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV["THE_MOVIE_DB_API"]}&language=en-US&page=2")
    
    response2 = conn2.get
    json2 = JSON.parse(response2.body, symbolize_names: true)
    @top_40 = [json[:results], [json2[:results]]].flatten
  end

  def search
    search = params[:search]

    redirect_to "/movies/results?q=#{search.downcase}"
  end

  def search_results; end
end
