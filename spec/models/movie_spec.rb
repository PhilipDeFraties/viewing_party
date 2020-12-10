require 'rails_helper'

describe Movie, type: :model do
  describe "validations" do
    it { should validate_uniqueness_of :api_id }
    it { should validate_presence_of :title }
  end

  describe "relationships" do
    it {should have_many :parties}
  end

  it ".check_db" do
    Movie.delete_all
    movie_1 = create :movie
    movie_params = {title: 'The Fountain', runtime: '145', api_id: '5555', logo: '/sdafahsdlkfjhasd.jpg'}
    Movie.check_db(movie_1.api_id, movie_params)
    expect(Movie.all.count).to eq(1)
    expect(Movie.last).to eq(movie_1)
    Movie.check_db(movie_params[:api_id], movie_params)
    movie_2 = Movie.last
    expect(Movie.all.count).to eq(2)
    expect(Movie.last).to eq(movie_2)
    expect(movie_2.title).to eq('The Fountain')
  end
end
