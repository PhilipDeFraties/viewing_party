require 'rails_helper'

RSpec.describe "Movie Search Results page" do
  describe "As a registered user, when I visit the discover page and fill in the form" do
    before :each do 
      @user_1 = create :user

      visit '/'
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Login'
      visit '/discover'
    end

    it 'I search for a movie and it shows the 17 results on the /movie/resutls page' do
      VCR.use_cassette('search_jurassic_park') do
        fill_in :search, with: 'Jurassic Park'
        click_on 'Find Movies'
        expect(current_path).to eq('/movies/search')
        within('#movies-table') do
          expect(all('tr').count).to eq(17)
        end
     end
    end

    it 'I see the rating for each movie and each movie title is a link to its show page' do
      VCR.use_cassette('search_jurassic_park') do
        fill_in :search, with: 'Jurassic Park'
        click_on 'Find Movies'
        expect(current_path).to eq('/movies/search')
        expect(page).to have_css('.rating')
        expect(page).to have_css('.title')
        rating = all('.rating')
        title = all('.title')
        expect(rating).not_to be_empty
        expect(title).not_to be_empty
      end
    end

    it "When I click on a movies link, I am taken to its show page" do
      VCR.use_cassette('search_jurassic_park') do
        fill_in :search, with: 'Jurassic Park'
        click_on 'Find Movies'
        expect(current_path).to eq('/movies/search')
        within first('.title') do
          click_link
        end
      end
    end

    it "I can search for another movie" do
      VCR.use_cassette('search_jurassic_park') do
        fill_in :search, with: 'Jurassic Park'
        click_on 'Find Movies'
        VCR.use_cassette('search_parasite') do
          fill_in :search, with: 'Parasite'
          click_on 'Find Movies'
          within('#movies-table') do
            expect(all('tr').count).to eq(20)
          end
          expect(current_path).to eq('/movies/search')
          expect(page).to have_css('.rating')
          expect(page).to have_css('.title')
          rating = all('.rating')
          title = all('.title')
          expect(rating).not_to be_empty
          expect(title).not_to be_empty
        end
      end
    end
  end
end 