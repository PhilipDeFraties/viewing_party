class MovieResults
  attr_reader :title, :vote_average, :movie_id
  def initialize(attrs)
    @title = attrs[:title]
    @vote_average = attrs[:vote_average]
    @movie_id = attrs[:id]
  end
end