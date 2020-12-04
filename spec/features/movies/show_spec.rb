require 'rails_helper'

RSpec.describe "Movie Details page" do
  describe "As a registered user, when I visit a movies detail page" do
    before :each do 
      @user_1 = create :user

      visit '/'
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Login'
      visit '/discover'
      VCR.insert_cassette('jurassic_search')
    end

    after :each do
      VCR.eject_cassette('jurassic_search')
    end

    it 'I see a button to create a viewing party' do
      
        fill_in :search, with: 'Jurassic Park'
        click_on 'Find Movies'
        expect(current_path).to eq('/movies/search')
        within first('.title') do
          click_link
        end
      
      
        expect(current_path).to eq('/movies/329')
        expect(page).to have_button('Create Viewing Party for Movie')
        click_on 'Create Viewing Party for Movie'
        expect(current_path).to eq('/viewing-party/new')
      
    end

    it 'I see a button to create a viewing party' do
      fill_in :search, with: 'Jurassic Park'
      click_on 'Find Movies'
      expect(current_path).to eq('/movies/search')
      within first('.title') do
        click_link
      end
      expect(page).to have_css('#title')
      expect(page).to have_content('Jurrasic Park')
      expect(page).to have_css('#vote-average')
      expect(page).to have_content('Vote Average: 6.0')
      expect(page).to have_css('#runtime')
      expect(page).to have_content('Runtime: 1hr 54min')
      expect(page).to have_css('#genre')
      expect(page).to have_content("Genre(s): ")
      expect(page).to have_css('#description')
      expect(page).to have_content('')
      expect(page).to have_css('#cast')
      expect(page).to have_content('')
      expect(page).to have_css('#review')
      expect(page).to have_content('')
    end
  end
end