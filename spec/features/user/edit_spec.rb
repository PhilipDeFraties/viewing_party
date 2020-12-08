require 'rails_helper'

RSpec.describe 'User edit' do
  describe 'As an authenticated user,' do
    before(:each) do
      @user_1 = create :user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    end

    describe 'when I visit the edit profile page' do
      before(:each) do
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
              expect(@user_1.email).to eq('different_email@email.com')
              expect(@user_1.username).to eq('Different Name')
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

    describe "When I visit the change password page" do
      before(:each) do
        visit "users/#{@user_1.id}/change_password"
      end

      it "I see fields for a new password and confirmation" do
        fill_in "user[password]", with: '123'
        fill_in "user[password_confirmation]", with: '123'
        click_on("Update Password")

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content('Password changed!')
        expect(@user_1.password).to eq('123')
        expect(@user_1.password_confirmation).to eq('123')
      end

      it "if password doesn't match password confirmation there is an error" do
        fill_in "user[password]", with: '123'
        fill_in "user[password_confirmation]", with: '456'
        click_on("Update Password")

        expect(current_path).to eq("/users/#{@user_1.id}/change_password")
        expect(page).to have_content("Password confirmation doesn't match Password")
      end

      it "if fields are left blank there is an error" do
        fill_in "user[password]", with: ''
        fill_in "user[password_confirmation]", with: ''
        click_on("Update Password")

        expect(current_path).to eq("/users/#{@user_1.id}/change_password")
        expect(page).to have_content("Password confirmation doesn't match Password")
      end
    end
  end
end
