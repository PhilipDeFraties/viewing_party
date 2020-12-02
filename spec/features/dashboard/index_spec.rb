require 'rails_helper'

RSpec.describe 'Dashboard Page' do
  describe 'As an authenticated user, when I visit my dashboard page' do
    before(:each) do
      
      @party_1 = Party.create!(email: 'user_2@email.com', password: 'password', name: 'User Two')
      @party_2 = Party.create!(email: 'user_2@email.com', password: 'password', name: 'User Two')
      
      visit 'login'
      fill_in :email, with: user_1.email
      fill_in :password, with: user_1.password

      visit '/dashboard'
    end

    it 'I see a welcome message' do
      within '#welcome_msg' do
        expect(page).to have_content('Welcome MovieWatcher1245!')
      end
    end

    it 'I see a button that leads to the discover movies page discover movies' do
      within '#discover-button' do
        expect(page).to have_button('Discover Movies')
        click_button 'Discover Movies'
        expect(current_path).to eq('/discover')
      end
    end

    it "if I don't have any friends, I see a message" do
      within '#friends' do
        expect(page).to have_content('You currently have no friends.')
    end

    it 'I can add a friend and they appear on my friends list' do
      within '#friends-search' do
        fill_in :search, with: @user_2.email
        click_button 'Add Friend'
      end
      expect(current_path).to eq('/dashboard') 
      within '#friends' do
        expect(page).to have_content(@user_2.name)
      end
    end

    it 'if I enter an incorrect email address I see an error message' do
      within '#friends-search' do
        fill_in :search, with: 'incorrect_email@gmail.com'
        click_button 'Add Friend'
      end
      expect(current_path).to eq('/dashboard')
       expect(page).to have_content('User not found.')
      within '#friends' do
        expect(page).to_not have_content(@user_2.name)
      end
    end
  end

  it 'I can see all of my viewing parties' do
      within '#viewing-parties' do
        expect(page).to have_content("Harry Potter and the Sorcerer's Stone")
        expect(page).to have_content('December 10, 2020')
        expect(page).to have_content('7:00 PM')
        expect(page).to have_content('Hosting')

        expect(page).to have_content("Fellowship of the Ring")
        expect(page).to have_content('December 11, 2020')
        expect(page).to have_content('8:00 PM')
        expect(page).to have_content('Invited')
      end
    end
  end
end