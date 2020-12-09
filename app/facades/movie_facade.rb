class MovieFacade
  def self.details(movie_id)
    json = MovieService.movie_details(movie_id)
    @movie = MovieDetails.new(json)
  end

  def self.top40
    json = MovieService.top40
    json.map do |movie|
      MovieResults.new(movie)
    end
  end

  def self.search(search)
    json = MovieService.search(search)
    json.map do |movie|
      MovieResults.new(movie)
    end
  end

  def self.trailer(movie_id)
    json = MovieService.trailer(movie_id)
    if json.nil?
      @trailer = nil
    else
      @trailer = MovieTrailer.new(json)
    end
  end
end
