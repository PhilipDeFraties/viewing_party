require 'rails_helper'
RSpec.describe "Movie Search Results page as a registered user" do
  before :each do
    user = create :user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/discover'
  end

  feature "Searching for a movie" do
    scenario 'I search for a movie and it shows the 17 results on the /movie/resutls page', :vcr do
      fill_in :search, with: 'Parasite'
      click_on 'Find Movies'
      expect(current_path).to eq('/movies/search')
      within('#movies-table') do
        expect(all('tr').count).to eq(20)
      end
      expect(page).to have_css('.rating')
      expect(page).to have_css('.title')
      rating = all('.rating')
      title = all('.title')
      expect(rating).not_to be_empty
      expect(title).not_to be_empty
    end

    scenario "When I search for another movie after an initial search", :vcr do
      fill_in :search, with: 'Parasite'
      click_on 'Find Movies'
      expect(current_path).to eq('/movies/search')
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

    scenario "Keyword search yields no results", :vcr do
      visit '/discover'
      fill_in :search, with: '55555555'
      click_on 'Find Movies'
      expect(current_path).to eq('/movies/search')
    end
  end
end

describe 'As an unregistered user, when I visit the search results page' do
  it 'I am redirected to the home page to log in' do
    visit movies_search_path
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Please login.')
  end
end
