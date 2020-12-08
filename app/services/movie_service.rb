class MovieService
  def self.movie_details(movie_id)
    conn = Faraday.new("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US&append_to_response=credits%2Creviews")
    response = conn.get
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.top40
    conn = Faraday.new("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US")
    response = conn.get
    json = JSON.parse(response.body, symbolize_names: true)

    conn2 = Faraday.new("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US&page=2")
    response2 = conn2.get
    json2 = JSON.parse(response2.body, symbolize_names: true)
    [json[:results], [json2[:results]]].flatten
  end

  def self.search(search)
    conn = Faraday.new("https://api.themoviedb.org/3/search/movie?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US&query=#{search}%20")
    response = conn.get
    json = JSON.parse(response.body, symbolize_names: true)
    json[:results]
  end
end