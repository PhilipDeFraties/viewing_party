require 'rails_helper'

RSpec.describe "Top 40 movies page" do
  describe "As a registered user, when I visit /movies/top40" do
    before :each do 
      @user_1 = create :user

      visit '/'
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Login'
    end
    
    it "I see the top 40 movies in a table" do
      VCR.use_cassette('top_0_20') do
        VCR.use_cassette('top_20_40') do
          visit '/movies/top40'
          within('#movies-table') do
            expect(all('tr').count).to eq(40)
          end
        end
      end
    end

    it "I see the rating for each movie and each movie title is a link to its show page" do
      VCR.use_cassette('top_0_20') do
        VCR.use_cassette('top_20_40') do
          visit '/movies/top40'
          expect(page).to have_css('.rating')
          expect(page).to have_css('.title')
          rating = all('.rating')
          title = all('.title')
          expect(rating).not_to be_empty
          expect(title).not_to be_empty
        end 
      end
    end

    it "When I click on a movies link, I am taken to its show page" do
      VCR.use_cassette('top_0_20') do
        VCR.use_cassette('top_20_40') do
          visit '/movies/top40'
          within first('.title') do
            click_link
          end
        end 
      end
    end

    it "I can search for a movie" do
      VCR.use_cassette('top_0_20') do
        VCR.use_cassette('top_20_40') do
          visit '/movies/top40'
          VCR.use_cassette('search_jurassic_park') do
            fill_in :search, with: 'Jurassic Park'
            click_on 'Find Movies'
              within('#movies-table') do
                expect(all('tr').count).to eq(17)
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
  end
end
