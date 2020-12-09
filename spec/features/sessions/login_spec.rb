require 'rails_helper'

RSpec.describe "Login/Session Creation" do
  before :each do
    @user = User.create!(email: 'test@fake.com', username: 'heftyjake', password: 'heftybags', password_confirmation: 'heftybags',)
    visit root_path
  end
  it "When I visit the login path I am able to login with valid credentials" do
    within ("#login-form") do
      fill_in :email,	with: @user.email
      fill_in :password,	with: @user.password
      click_button 'Login'
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("You are now logged in")
  end
  it "Invalid email " do
    within ("#login-form") do
      fill_in :email,	with: "Wrongemail"
      fill_in :password,	with: @user.password
      click_button 'Login'
    end

    expect(page).to have_content("Email and/or password is incorrect")
    expect(current_path).to eq(root_path)
  end

  it "Invalid password " do
    within ("#login-form") do
      fill_in :email,	with: @user.email
      fill_in :password,	with: "wrongpassword"
      click_button 'Login'
    end

    expect(page).to have_content("Email and/or password is incorrect")
    expect(current_path).to eq(root_path)
  end
end
