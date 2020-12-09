class MovieService
  def self.movie_details(movie_id)
    uri = "/3/movie/#{movie_id}?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US&append_to_response=credits%2Creviews"
    get_results(uri)
  end

  def self.top40
    uri = "/3/movie/top_rated?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US"
    json = get_results(uri)

    uri = "/3/movie/top_rated?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US&page=2"
    json2 = get_results(uri)
    [json[:results], [json2[:results]]].flatten
  end

  def self.search(search)
    uri = "/3/search/movie?api_key=#{ENV['THE_MOVIE_DB_API']}&language=en-US&query=#{search}%20"
    json = get_results(uri)
    json[:results]
  end

  def self.get_results(uri)
    conn = Faraday.new(url: 'https://api.themoviedb.org')
    results = conn.get(uri)
    JSON.parse(results.body, symbolize_names: true)
  end
end
