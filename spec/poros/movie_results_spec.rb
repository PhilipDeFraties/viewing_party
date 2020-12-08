require "rails_helper"

RSpec.describe MovieResults do
  it "exists" do
    attrs =
      {
        "adult": false,
        "backdrop_path": "/fQq1FWp1rC89xDrRMuyFJdFUdMd.jpg",
        "genre_ids": [],
        "id": 761053,
        "original_language": "en",
        "original_title": "Gabriel's Inferno Part III",
        "overview": "The final part of the film adaption of the erotic romance novel Gabriel's Inferno written by an anonymous Canadian author under the pen name Sylvain Reynard.",
        "popularity": 36.427,
        "poster_path": "/qtX2Fg9MTmrbgN1UUvGoCsImTM8.jpg",
        "release_date": "2020-11-19",
        "title": "Gabriel's Inferno Part III",
        "video": false,
        "vote_average": 9.2,
        "vote_count": 466
      }

    movie_results = MovieResults.new(attrs)

    expect(movie_results).to be_a MovieResults
    expect(movie_results.title).to eq("Gabriel's Inferno Part III")
    expect(movie_results.vote_average).to eq(9.2)
    expect(movie_results.movie_id).to eq(761053)
  end
end