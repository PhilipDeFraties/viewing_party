require 'rails_helper'

RSpec.describe 'User edit' do
  describe 'As an authenticated user, when I visit the edit profile page' do
    before(:each) do
      @user_1 = create :user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit "/users/#{@user_1.id}/edit"
    end

    it "I see a form prefilled with my user info" do
      expect(page).to have_field('user[username]', with: "#{@user_1.username}")
      expect(page).to have_field('user[email]', with: "#{@user_1.email}")
    end

    describe "When I enter a new name and email and click 'Update Profile'" do
      describe "I am redirected back to my dashboard" do
        describe "I see a flash message indicating my profile was updated" do
          it "And the welcome message shows my new username" do
            fill_in 'user[username]', with: 'Different Name'
            fill_in 'user[email]', with: 'different_email@email.com'
            click_button 'Update Profile'

            expect(current_path).to eq(dashboard_path)
            expect(page).to have_content('Profile has been updated!')
            expect(page).to have_content('Welcome Different Name!')
          end
        end
      end
    end

    describe 'When I enter an email or username already in use' do
      it 'the page is refreshed and I see an error message' do
        user_2 = create :user
        fill_in 'user[email]', with: user_2.email
        fill_in 'user[username]', with: user_2.username
        click_button 'Update Profile'
        
        expect(current_path).to eq("/users/#{@user_1.id}/edit")
        expect(page).to have_content('Email has already been taken and Username has already been taken')
        expect(page).to have_field('user[username]', with: "#{@user_1.username}")
        expect(page).to have_field('user[email]', with: "#{@user_1.email}")
      end
    end

    describe "When I leave fields blank" do
      it 'the page is refreshed and I see an error message' do

        fill_in 'user[username]', with: ''
        fill_in 'user[email]', with: ''
        click_button 'Update Profile'

        expect(current_path).to eq("/users/#{@user_1.id}/edit")
        expect(page).to have_content("Username can't be blank and Email can't be blank")
      end
    end
  end
end
