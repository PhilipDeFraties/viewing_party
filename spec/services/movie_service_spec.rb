require 'rails_helper'

describe MovieService do
  context "instance methods" do
    context "#movie_details" do
      it "returns movie details data" do
        VCR.use_cassette('spirited_away_details') do
          details = MovieService.movie_details(129)
          expect(details).to be_a Hash

          expect(details).to have_key :title
          expect(details[:title]).to be_a(String)

          expect(details).to have_key :runtime
          expect(details[:runtime]).to be_a(Integer)

          expect(details).to have_key :vote_average
          expect(details[:vote_average]).to be_a(Float)

          expect(details).to have_key :overview
          expect(details[:overview]).to be_a(String)

          expect(details).to have_key :credits
          expect(details[:credits][:cast]).to be_a(Array)

          expect(details).to have_key :reviews
          expect(details[:reviews][:results]).to be_a(Array)

          expect(details).to have_key :poster_path
          expect(details[:poster_path]).to be_a(String)
        end
      end
    end

    context "#top40" do
      it "returns the top 40 movies" do
        VCR.use_cassette('top_40') do
          top40 = MovieService.top40
          expect(top40).to be_a Array
          first_movie = top40.first

          expect(first_movie).to have_key :title
          expect(first_movie[:title]).to be_a(String)

          expect(first_movie).to have_key :id
          expect(first_movie[:id]).to be_a(Integer)

          expect(first_movie).to have_key :vote_average
          expect(first_movie[:vote_average]).to be_a(Float)
        end
      end
    end

    context "#search" do
      it "returns the movie search results" do
        VCR.use_cassette('mulan_search') do
          search = MovieService.search('Mulan')
          expect(search).to be_a Array
          first_movie = search.first

          expect(first_movie).to have_key :title
          expect(first_movie[:title]).to be_a(String)

          expect(first_movie).to have_key :id
          expect(first_movie[:id]).to be_a(Integer)

          expect(first_movie).to have_key :vote_average
          expect(first_movie[:vote_average]).to be_a(Numeric)
        end
      end
    end
  end
end
