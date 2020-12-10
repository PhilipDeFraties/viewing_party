require 'rails_helper'

RSpec.describe MovieTrailer do 
  it "exists" do
    attrs = {
      key: 'QWBKEmWWL38'
    }

    movie_trailer = MovieTrailer.new(attrs)

    expect(movie_trailer).to be_a MovieTrailer
    expect(movie_trailer.key).to eq('QWBKEmWWL38') 
  end
end