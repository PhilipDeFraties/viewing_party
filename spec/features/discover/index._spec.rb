require 'rails_helper'

RSpec.describe "Discover Page" do
  describe "As a registered user, when I visit /discover" do
    before :each do 
      @user_1 = create :user

      visit '/'
      within ("#login-form") do
        fill_in :email,	with: @user_1.email
        fill_in :password,	with: @user_1.password
        click_button 'Login'
      end
      visit '/discover'
    end

    it "I see a button to discover top 40 movies and when I click the button, I am redirected to the top 40 movie page" do
      VCR.use_cassette('top_0_20') do
        VCR.use_cassette('top_20_40') do
          expect(page).to have_button('Find Top Rated Movies')
          click_on 'Find Top Rated Movies'
          expect(current_path).to eq('/movies/top40')
        end 
      end
    end

    it "A text field to search movies by name" do
      expect(page).to have_button('Find Movies')
      expect(page).to have_field(:search)
    end

    it "When I fill in the movie search field and click search, I am redirected to the movie search page" do
      VCR.use_cassette('search_jurassic_park') do
        fill_in :search,	with: "Jurassic Park" 
        click_on 'Find Movies'
        expect(current_path).to eq('/movies/search')
      end
    end
  end
end
