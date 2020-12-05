require "rails_helper"

RSpec.describe "Welcome Page" do
  describe "As a visitor when I visit the welcome index page" do
    before :each do
      visit "/"
    end
    it "I see a welcome message" do
      expect(page).to have_content("Welcome to Viewing Party")
    end

    it "I see a brief description of the app" do
      within "#app-desc" do
        expect(page).to have_content("Viewing party is an application in which users can explore movie options and create a viewing party event for the user and friends.")
      end
    end

    it "I see a button to log in" do
      expect(page).to have_button('Login')
    end

    it "I see a button to register as a user" do
      expect(page).to have_button('Register')
    end
  end

  describe 'As a logged in user' do
    it "When I visit the welcome page I am redirected to my user dashboard" do
      @user_1 = create :user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit root_path

      expect(current_path).to eq('/user/dashboard')
    end
  end
end
