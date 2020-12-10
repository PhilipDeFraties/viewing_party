require "rails_helper"

RSpec.describe MovieDetails do
  it "exists" do
    attrs = {
      title: 'Spirited Away',
      runtime: 125,
      vote_average: 8.5,
      genres:  [{
          "id": 16,
          "name": "Animation"
        },
        {
          "id": 10751,
          "name": "Family"
        },
        {
          "id": 14,
          "name": "Fantasy"
        }],
      overview: 'A young girl, Chihiro, becomes trapped in a strange new world of spirits.',
      credits: {
        cast: [
        {
          "adult": false,
          "gender": 0,
          "id": 19587,
          "known_for_department": "Acting",
          "name": "Rumi Hiiragi",
          "original_name": "Rumi Hiiragi",
          "popularity": 1.555,
          "profile_path": "/zITaVtFyc4xSM3mxSoPRWHbqgJI.jpg",
          "cast_id": 3,
          "character": "Chihiro Ogino / Sen (voice)",
          "credit_id": "52fe421bc3a36847f8004a97",
          "order": 0
        }]},
      reviews: {
        results: [
          {
            "author": "ZeBlah",
            "author_details": {
              "name": "ZeBlah",
              "username": "TheBlah",
              "avatar_path": "/d7rZv7xFhXHy0OLbVc2byJiZwEU.jpg",
              "rating": 10
            },
            "content": "One of the great \"masters\" of the anime art. Somehow, if I would personally associate \"Akira\" to \"self-destruction\", then this anime would be the opposite :)",
            "created_at": "2019-06-29T20:24:51.877Z",
            "id": "5d17c91385702e001eb921db",
            "updated_at": "2019-07-02T17:08:18.746Z",
            "url": "https://www.themoviedb.org/review/5d17c91385702e001eb921db"
          }
    ]},
        poster_path: '/2TeJfUZMGolfDdW6DKhfIWqvq8y.jpg',
        videos: {
      results: [
        {
          "id": "592c5d16c3a36877bc0817da",
          "iso_639_1": "en",
          "iso_3166_1": "US",
          "key": "ByXuk9QqQkk",
          "name": "Spirited Away - Official Trailer",
          "site": "YouTube",
          "size": 720,
          "type": "Trailer"
            }
          ]
        }
    }

    movie_details = MovieDetails.new(attrs)

    expect(movie_details).to be_a MovieDetails
    expect(movie_details.title).to eq('Spirited Away')
    expect(movie_details.vote_average).to eq(8.5)
    expect(movie_details.runtime).to eq(125)
    expect(movie_details.genres).to eq('Animation, Family, Fantasy')
    expect(movie_details.format_genres(attrs[:genres])).to eq('Animation, Family, Fantasy')
    expect(movie_details.overview).to eq('A young girl, Chihiro, becomes trapped in a strange new world of spirits.')
    expect(movie_details.cast).to eq([{:adult=>false,
        :gender=>0,
        :id=>19587,
        :known_for_department=>'Acting',
        :name=>'Rumi Hiiragi',
        :original_name=>'Rumi Hiiragi',
        :popularity=>1.555,
        :profile_path=>'/zITaVtFyc4xSM3mxSoPRWHbqgJI.jpg',
        :cast_id=>3,
        :character=>'Chihiro Ogino / Sen (voice)',
        :credit_id=>'52fe421bc3a36847f8004a97',
        :order=>0}])
    expect(movie_details.reviews).to eq([{:author=>'ZeBlah',
        :author_details=>{:name=>'ZeBlah', :username=>'TheBlah', :avatar_path=>'/d7rZv7xFhXHy0OLbVc2byJiZwEU.jpg', :rating=>10},
        :content=>
        "One of the great \"masters\" of the anime art. Somehow, if I would personally associate \"Akira\" to \"self-destruction\", then this anime would be the opposite :)",
        :created_at=>'2019-06-29T20:24:51.877Z',
        :id=>'5d17c91385702e001eb921db',
        :updated_at=>'2019-07-02T17:08:18.746Z',
        :url=>'https://www.themoviedb.org/review/5d17c91385702e001eb921db'}])
    expect(movie_details.logo).to eq('/2TeJfUZMGolfDdW6DKhfIWqvq8y.jpg')
    expect(movie_details.format_runtime).to eq('2 hrs 5 mins')
  end
end