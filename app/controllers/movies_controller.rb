class MoviesController < ApplicationController
  def show
    details_conn = Faraday.new("https://api.themoviedb.org/3/movie/#{params[:movie_id]}?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US")
    details_response = details_conn.get
    details = JSON.parse(details_response.body, symbolize_names: true)

    cast_conn = Faraday.new("https://api.themoviedb.org/3/movie/#{params[:movie_id]}/credits?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US")
    cast_response = cast_conn.get
    cast = JSON.parse(cast_response.body, symbolize_names: true)

    reviews_conn = Faraday.new("https://api.themoviedb.org/3/movie/#{params[:movie_id]}/reviews?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US")
    reviews_response = reviews_conn.get
    reviews = JSON.parse(reviews_response.body, symbolize_names: true)

    @results = { details: details, cast: cast, reviews: reviews }
  end

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
    flash[:error] = 'No movies matched your search.' if @results.empty?
  end
end
