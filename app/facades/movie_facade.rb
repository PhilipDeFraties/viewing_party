class MovieFacade
  def self.details(movie_id)
    conn = Faraday.new("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US&to_response=credits%2Creviews")
    response = conn.get
    parse = JSON.parse(response.body, symbolize_names: true)
    require 'pry'; binding.pry
  end
end