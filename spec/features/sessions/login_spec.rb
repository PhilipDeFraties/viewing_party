require 'rails_helper'

RSpec.describe "Login/Session Creation" do
  before :each do
    @user = User.create!(email: 'test@fake.com', username: 'heftyjake', password: 'heftybags', password_confirmation: 'heftybags',)
    visit '/'
  end
  it "When I visit the login path I am able to login with valid credentials" do  
    fill_in :email,	with: @user.email
    fill_in :password,	with: @user.password

    click_button "Login"

    expect(current_path).to eq("/user/dashboard")
    expect(page).to have_content("You are now logged in")
  end
  it "Invalid email " do
    fill_in :email,	with: 'fake@email.com'
    fill_in :password,	with: @user.password

    click_button "Login"

    expect(page).to have_content("Email and/or password is incorrect")
    expect(current_path).to eq("/")
  end

  it "Invalid password " do
    fill_in :email,	with: @user.email
    fill_in :password,	with: 'wrong_password'

    click_button "Login"

    expect(page).to have_content("Email and/or password is incorrect")
    expect(current_path).to eq("/")
  end
  
end
