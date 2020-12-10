require 'rails_helper'
RSpec.describe "Movie Search Results page" do
  describe 'As an unregistered user, when I visit the search results page' do
    it 'I am redirected to the home page to log in' do
      visit movies_search_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Please login.')
    end
  end

  describe "As a registered user, when I visit the discover page and fill in the form" do
    before :each do
      @user_1 = create :user
      visit root_path
      within ("#login-form") do
        fill_in :email,	with: @user_1.email
        fill_in :password,	with: @user_1.password
        click_button 'Login'
      end
      visit '/discover'
      VCR.insert_cassette('parasite_search')
    end
    after :each do
      VCR.eject_cassette('parasite_search')
    end
    it 'I search for a movie and it shows the 17 results on the /movie/resutls page' do
      fill_in :search, with: 'Parasite'
      click_on 'Find Movies'
      expect(current_path).to eq('/movies/search')
      within('#movies-table') do
        expect(all('tr').count).to eq(20)
      end
    end
    it 'I see the rating for each movie and each movie title is a link to its show page' do
      fill_in :search, with: 'Parasite'
      click_on 'Find Movies'
      expect(current_path).to eq('/movies/search')
      expect(page).to have_css('.rating')
      expect(page).to have_css('.title')
      rating = all('.rating')
      title = all('.title')
      expect(rating).not_to be_empty
      expect(title).not_to be_empty
    end
    it "When I click on a movies link, I am taken to its show page" do
      fill_in :search, with: 'Parasite'
      click_on 'Find Movies'
      expect(current_path).to eq('/movies/search')
      within first('.title') do
        VCR.use_cassette('parasite_details') do
          click_link
        end
      end
    end
    it "I can search for another movie" do
      fill_in :search, with: 'Parasite'
      click_on 'Find Movies'
      VCR.use_cassette('harry_search') do
        fill_in :search, with: 'Harry'
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

feature 'User searches for a movie via keyword search' do
  scenario "User search yields no results", :vcr do
    @user_1 = create :user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    visit '/discover'
    fill_in :search, with: '55555555'
    click_on 'Find Movies'
    

    expect(current_path).to eq('/movies/search')
    
  end
end
