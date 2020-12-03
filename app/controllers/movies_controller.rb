class MoviesController < ApplicationController
  def show; end

  def top40
    conn = Faraday.new("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US")
    response = conn.get
    json = JSON.parse(response.body, symbolize_names: true)

    conn2 = Faraday.new("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US&page=2")

    response2 = conn2.get
    json2 = JSON.parse(response2.body, symbolize_names: true)
    @top40 = [json[:results], [json2[:results]]].flatten
  end

  def search
    conn = Faraday.new("https://api.themoviedb.org/3/search/movie?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US&query=#{params[:search]}%20")
    response = conn.get
    json = JSON.parse(response.body, symbolize_names: true)
    @results = json[:results]
  end
end
