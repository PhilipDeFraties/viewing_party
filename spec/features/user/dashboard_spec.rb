require 'rails_helper'

RSpec.describe 'Dashboard Page' do
  describe 'As an authenticated user, when I visit my dashboard page' do
    before(:each) do
      @user_1 = create :user
      @user_2 = create :user
      @movie_1 = create :movie
      @movie_2 = create :movie
      @movie_3 = create :movie
      @movie_4 = create :movie
      @party_1 = Party.create!(user_id: @user_1.id, movie_id: @movie_1.id, date: '12-24-2020', time: '9:30', duration: 142)
      @party_2 = Party.create!(user_id: @user_2.id, movie_id: @movie_2.id, date: '12-19-2020', time: '4:30', duration: 120)
      @party_3 = Party.create!(user_id: @user_1.id, movie_id: @movie_3.id, date: '12-20-2020', time: '5:30', duration: 160)
      @party_4 = Party.create!(user_id: @user_2.id, movie_id: @movie_4.id, date: '12-21-2020', time: '6:30', duration: 200)
      PartyGuest.create!(user_id: @user_1.id, party_id: @party_2.id)
      PartyGuest.create!(user_id: @user_1.id, party_id: @party_4.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit dashboard_path
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

    describe "When I attempt to add a friend using a valid user email" do
      describe "My dashboard is refreshed and I see my new friend on my list" do
        it "and I am added to my new friend's friendlist" do
          within '#friends-search' do
            fill_in :friends_email, with: @user_2.email
            click_button 'Add Friend'
          end
          expect(current_path).to eq(dashboard_path)
          within '#friends' do
            expect(page).to have_content(@user_2.username)
          end
          expect(@user_2.friends).to include(@user_1)
        end
      end
    end

    describe "When I attempt to add a friend using an invalid user email" do
      it "I see a flash message indicating the user doesn't exist" do
        within '#friends-search' do
          fill_in :friends_email, with: 'email@fake.com'
          click_button 'Add Friend'
        end
        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content('User does not exist.')
      end
    end

    describe "When I attempt to add a friend using my own email" do
      it "I see a flash message indicating I cannot add myself" do
        within '#friends-search' do
          fill_in :friends_email, with: "#{@user_1.email}"
          click_button 'Add Friend'
        end
        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content('You cannot add yourself as a friend.')
      end
    end

    it "I can see the viewing parties I'm hosting" do
      hosting_parties = [@party_1, @party_3]
      hosting_parties.each do |party|
        within "#party-#{party.id}" do
          assert page.has_xpath?("//img[@alt='No Image' and @src = 'https://image.tmdb.org/t/p/w500/#{party.movie.logo}']")
          expect(page).to have_content("#{party.movie.title}")
          expect(page).to have_content("#{party.date}")
          expect(page).to have_content("#{party.time}")
          expect(page).to have_content("Host")
        end
      end
    end

    it "I can see the viewing parties I'm invited to" do
      invited_to_parties = [@party_2, @party_4]
      invited_to_parties.each do |party|
        within "#party-#{party.id}" do
          assert page.has_xpath?("//img[@alt='No Image' and @src = 'https://image.tmdb.org/t/p/w500/#{party.movie.logo}']")
          expect(page).to have_content("#{party.movie.title}",)
          expect(page).to have_content("#{party.date}")
          expect(page).to have_content("#{party.time}")
          expect(page).to have_content("Invited")
        end
      end
    end

    it "If there are no scheduled parties, I see a message" do
      PartyGuest.delete_all
      Party.delete_all
      visit dashboard_path

      within "#parties" do
        expect(page).to have_content("No Parties Scheduled")
      end
    end

    it "I see a button to edit my profile, which takes me to an edit form" do
      expect(page).to have_link('Edit Profile')
      click_link 'Edit Profile'
      expect(current_path).to eq("/users/#{@user_1.id}/edit")
    end
  end
end
