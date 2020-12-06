require "rails_helper"

RSpec.describe "Welcome Page" do
  before :each do
    @user_1 = create :user
    visit root_path
  end

  describe "As a visitor when I visit the welcome index page I see" do
    it "a welcome message" do
      expect(page).to have_content("Welcome to Viewing Party")
    end

    it "a brief description of the app" do
      within "#app-desc" do
        expect(page).to have_content("Viewing party is an application in which users can explore movie options and create a viewing party event for the user and friends.")
      end
    end

    it "a button to log in that takes me to my user dashboard" do
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Login'
      expect(current_path).to eq(dashboard_path)
    end

    it "a button to register as a user that takes me to a registration form" do
      click_button 'Register'
      expect(current_path).to eq(register_path)
    end

    describe 'As a logged in user, when I visit the welcome page' do
      it "I am redirected to my user dashboard" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
        visit root_path
        expect(current_path).to eq(dashboard_path)
      end
    end
  end
end
