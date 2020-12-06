require 'rails_helper'

RSpec.describe "Top 40 movies page" do
  describe "As a registered user, when I visit /movies/top40" do
    before :each do
      @user_1 = create :user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit dashboard_path
      VCR.insert_cassette('top_40')
    end

    after :each do
      VCR.eject_cassette('top_40')
    end

    it "I see the top 40 movies in a table" do
      visit '/movies/top40'
      within('#movies-table') do
        expect(all('tr').count).to eq(40)
      end
    end

    it "I see the rating for each movie and each movie title is a link to its show page" do
      visit '/movies/top40'
      expect(page).to have_css('.rating')
      expect(page).to have_css('.title')
      rating = all('.rating')
      title = all('.title')
      expect(rating).not_to be_empty
      expect(title).not_to be_empty
    end

    it "When I click on a movies link, I am taken to its show page" do
      visit '/movies/top40'
      within first('.title') do
        VCR.use_cassette('movie_details') do
          click_link
        end
      end
    end

    it "I can search for a movie" do
      visit '/movies/top40'
      VCR.use_cassette('search_jurassic_park') do
        fill_in :search, with: 'Jurassic Park'
        click_on 'Find Movies'
        expect(current_path).to eq('/movies/search')
      end
    end
  end
end
