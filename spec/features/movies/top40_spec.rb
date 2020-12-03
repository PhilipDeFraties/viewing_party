require 'rails_helper'

RSpec.describe "Top 40 movies page" do
  describe "As a registered user, when I visit /movies/top40" do
    before :each do 
      @user_1 = create :user

      visit '/'
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Login'
      visit '/movies/top40'
    end
    
    it "I see the top 40 movies in a table" do
      within('#movies-table') do
        expect(all('tr').count).to eq(40)
      end
    end

    it "I see the rating for each movie and each movie title is a link to its show page" do
      expect(page).to have_css('.rating')
      expect(page).to have_css('.title')
      rating = all('.rating')
      title = all('.title')
      expect(rating).not_to be_empty
      expect(title).not_to be_empty
    end

    it "When I click on a movies link, I am taken to its show page" do
      within first('.title') do
        click_link
      end
    end
    
  end
end
