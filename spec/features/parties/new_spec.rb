require 'rails_helper'

RSpec.describe "New party page" do
  describe 'As an unregistered user, when I visit the new party page' do
    it 'I am redirected to the home page to log in' do
      visit viewing_party_new_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Please login.')
    end
  end
  
  describe "As a registered user when I visit a movies details page" do
    before :each do
      @user_1 = create :user
      @user_2 = create :user
      Friendship.create(user_id: @user_1.id, friend_id: @user_2.id)


      visit '/'
      within ("#login-form") do
        fill_in :email,	with: @user_1.email
        fill_in :password,	with: @user_1.password
        click_button 'Login'
      end
    end

    it "I can create a new viewing party where the movie is not in the database" do
      VCR.use_cassette('parasite_details') do
        Movie.delete_all
        visit '/movies/291545'
        click_on 'Create Viewing Party for Movie'
        expect(current_path).to eq('/viewing-party/new')
        fill_in :duration, with: '180'
        fill_in :date, with: Date.today.strftime("%m-%d-%Y")
        fill_in :time, with: '08:00 PM'
        find(:css, "#party_guests_#{@user_2.id}[value='#{@user_2.id}']").set(true)
        click_on 'Save'
        expect(current_path).to eq(dashboard_path)
        expect(Movie.all.count).to eq(1)
        movie = Movie.last
        expect(movie.title).to eq('Parasite')
        party = Party.last
        expect(PartyGuest.all.count).to eq(1)
        expect(party.users).to eq([@user_2])
      end
    end

    it "I can create a new viewing party where the movie is already in the database" do
      @movie = Movie.create!(api_id: 291545, title: 'Parasite', logo: "/astKJpagcTTqybiAZ6qpakVqmow.jpg", runtime: 142)
      VCR.use_cassette('parasite_details') do
        Movie.delete_all
        visit '/movies/291545'
        click_on 'Create Viewing Party for Movie'
        expect(current_path).to eq('/viewing-party/new')
        fill_in :duration, with: '180'
        fill_in :date, with: Date.today.strftime("%m-%d-%Y")
        fill_in :time, with: '08:00 PM'
        find(:css, "#party_guests_#{@user_2.id}[value='#{@user_2.id}']").set(true)
        click_on 'Save'
        expect(Movie.all.count).to eq(1)
        movie = Movie.last
        expect(movie.title).to eq('Parasite')
      end
    end

    it "I can create a new viewing party without adding friends" do
      @movie = Movie.create!(api_id: 291545, title: 'Parasite', logo: "/astKJpagcTTqybiAZ6qpakVqmow.jpg", runtime: 142)
      VCR.use_cassette('parasite_details') do
        Movie.delete_all
        visit '/movies/291545'
        click_on 'Create Viewing Party for Movie'
        expect(current_path).to eq('/viewing-party/new')
        fill_in :duration, with: '180'
        fill_in :date, with: Date.today.strftime("%m-%d-%Y")
        fill_in :time, with: '08:00 PM'
        click_on 'Save'
        expect(Movie.all.count).to eq(1)
        expect(PartyGuest.all.count).to eq(0)
      end
    end

    it "if I enter a negative duration I get an error message" do
      @movie = Movie.create!(api_id: 291545, title: 'Parasite', logo: "/astKJpagcTTqybiAZ6qpakVqmow.jpg", runtime: 142)
      VCR.use_cassette('parasite_details') do
        visit '/movies/291545'
        click_on 'Create Viewing Party for Movie'
        expect(current_path).to eq('/viewing-party/new')
        fill_in :duration, with: '-180'
        fill_in :date, with: Date.today.strftime("%m-%d-%Y")
        fill_in :time, with: '08:00 PM'
        find(:css, "#party_guests_#{@user_2.id}[value='#{@user_2.id}']").set(true)
        click_on 'Save'
        expect(page).to have_content('Duration must be greater than 0')
      end
    end

    it "if I leave fields blank I see an error message" do
      @movie = Movie.create!(api_id: 291545, title: 'Parasite', logo: "/astKJpagcTTqybiAZ6qpakVqmow.jpg", runtime: 142)
      VCR.use_cassette('parasite_details') do
        visit '/movies/291545'
        click_on 'Create Viewing Party for Movie'
        expect(current_path).to eq('/viewing-party/new')
        fill_in :duration, with: ""
        fill_in :date, with: ""
        fill_in :time, with: ""
        click_on 'Save'
        expect(page).to have_content("Time can't be blank, Date can't be blank, Duration can't be blank, and Duration is not a number")
      end
    end
  end
end
