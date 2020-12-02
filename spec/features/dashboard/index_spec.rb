require 'rails_helper'

RSpec.describe 'Dashboard Page' do
  describe 'As an authenticated user, when I visit my dashboard page' do
    before(:each) do
      @user_1 = create :user
      @user_2 = create :user
      @movie_1 = create :movie
      @movie_2 = create :movie
      @party_1 = Party.create!(user_id: @user_1.id, movie_id: @movie_1.id, date: '12-24-2020', time: '9:30')
      @party_2 = Party.create!(user_id: @user_2.id, movie_id: @movie_2.id, date: '12-19-2020', time: '4:30')
      PartyGuest.create!(user_id: @user_1.id, party_id: @party_2.id)

      visit '/'
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Login'
    end

    it 'I see a welcome message' do
      within '#welcome-msg' do
        expect(page).to have_content("Welcome #{@user_1.username}!")
      end
    end

    it 'I see a button that leads to the discover movies page discover movies' do
      within '#discover-button' do
        expect(page).to have_button('Discover Movies')
        click_button 'Discover Movies'
        expect(current_path).to eq('/discover')
      end
    end

    it "if I don't have any friends, it says I have no friends" do
      within '#friends' do
        expect(page).to have_content('You currently have no friends.')
      end
    end

    it 'I can add a friend and they will appear on my friends list' do
      within '#friends-search' do
        fill_in :friends_email, with: @user_2.email
        click_button 'Add Friend'
      end
      expect(current_path).to eq('/user/dashboard')
      within '#friends' do
        expect(page).to have_content(@user_2.username)
      end
    end

    it "I see a flash message if the email is incorrect" do
      within '#friends-search' do
        fill_in :friends_email, with: 'email@fake.com'
        click_button 'Add Friend'
      end
      expect(current_path).to eq('/user/dashboard')
      expect(page).to have_content('User does not exist.')
    end

    it 'I can see all of my viewing parties' do
      within "#viewing-party-#{@party_1.id}" do
        expect(page).to have_content(@movie_1.title)
        expect(page).to have_content(@party_1.date)
        expect(page).to have_content(@party_1.time)
        expect(page).to have_content('Host')
      end

      within "#viewing-party-#{@party_2.id}" do
        expect(page).to have_content(@movie_2.title)
        expect(page).to have_content(@party_2.date)
        expect(page).to have_content(@party_2.time)
        expect(page).to have_content('Invited')
      end
    end
  end
end
