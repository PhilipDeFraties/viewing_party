class MovieService
  def self.movie_details(movie_id)
    conn = Faraday.new("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US&append_to_response=credits%2Creviews")
    response = conn.get
    json = JSON.parse(response.body, symbolize_names: true)
  end
end