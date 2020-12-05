require 'rails_helper'

RSpec.describe "New party page" do
  describe "As a registered user when I visit a movies details page" do
    before :each do
      @user_1 = create :user
      @user_2 = create :user
      Friendship.create(user_id: @user_1.id, friend_id: @user_2.id)
      

      visit '/'
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Login'
    end

    it "I can create a new viewing party" do
      VCR.use_cassette('parasite_details') do
        visit '/movies/291545'
        click_on 'Create Viewing Party for Movie'
        expect(current_path).to eq('/viewing-party/new')
        expect(page).to have_css('#title')
        expect(page).to have_css('#duration')
        expect(page).to have_css('#date')
        expect(page).to have_css('#time')
        expect(page).to have_css('#friends')
        expect(page).to have_content('Parasite')
        expect(page).to have_content('93')
        expect(page).to have_content("#{@user_2.username}")
        expect(page).to have_button('Create Party')
      end
    end
  end
end
