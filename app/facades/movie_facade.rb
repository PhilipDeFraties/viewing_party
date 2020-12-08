class MovieFacade
  def self.details(movie_id)
    json = MovieService.movie_details(movie_id)
    @movie = MovieDetails.new(json)
  end
end