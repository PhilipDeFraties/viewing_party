class MovieService
  def self.movie_details(movie_id)
    uri = "/3/movie/#{movie_id}?&append_to_response=credits%2Creviews%2Cvideos"
    get_results(uri)
  end

  def self.top40
    page = 1
    movies = []
    2.times do
      uri = "/3/movie/top_rated?&page=#{page}"
      movies << get_results(uri)[:results]
      page += 1
    end
    movies.flatten
  end

  def self.search(search)
    uri = "/3/search/movie?&query=#{search}%20"
    json = get_results(uri)
    json[:results]
  end

  def self.get_results(uri)
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.params['api_key'] = ENV['THE_MOVIE_DB_API']
      faraday.params['language'] = 'en-US'
    end
    results = conn.get(uri)
    JSON.parse(results.body, symbolize_names: true)
  end
end
