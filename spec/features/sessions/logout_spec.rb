require 'rails_helper'

RSpec.describe "Logout/Session Deletion" do
  before :each do
    @user = User.create!(email: 'test@fake.com', username: 'heftyjake', password: 'heftybags', password_confirmation: 'heftybags',)
    visit root_path
    within ("#login-form") do
      fill_in :email,	with: @user.email
      fill_in :password,	with: @user.password
      click_button 'Login'
    end
  end

  describe "When I click the logout button I am logged out" do
    it "And I am redirected to the welcome page" do
      click_on 'Logout'

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You have successfully logged out")
      expect(page).to have_css('#email')
      expect(page).to have_css('#password')
      expect(page).to have_button('Login')
    end

  end
end
