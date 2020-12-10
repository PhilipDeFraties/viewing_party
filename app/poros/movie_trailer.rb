class MovieTrailer
  attr_reader :key

  def initialize(attributes)
    @key = attributes[:key]
  end
end
