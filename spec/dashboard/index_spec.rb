require 'rails_helper'

RSpec.describe 'Dashboard Page' do
  describe 'As an authenticated user, when I visit my dashboard page' do
    before(:each) do
      @user_1 = User.create!(email: 'user_1@email.com', password: 'password', name: 'User One')
      @user_2 = User.create!(email: 'user_2@email.com', password: 'password', name: 'User Two')
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
  end
end