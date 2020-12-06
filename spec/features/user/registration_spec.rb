require 'rails_helper'

RSpec.describe 'User Registration' do
  describe 'As a Visitor' do
    it 'I can register as a user' do
      visit register_path

      fill_in 'user[username]', with: 'Megan'
      fill_in 'user[email]', with: 'megan@example.com'
      fill_in 'user[password]', with: 'securepassword'
      fill_in 'user[password_confirmation]', with: 'securepassword'
      click_button 'Register'

      expect(current_path).to eq('/user/dashboard')
      expect(page).to have_content('Welcome, Megan!')
    end

    describe 'I can not register as a user if' do
      it 'I do not complete the registration form' do
        visit register_path
        click_button 'Register'

        expect(page).to have_button('Register')
        expect(page).to have_content("Password can't be blank")
        expect(page).to have_content("Username can't be blank")
        expect(page).to have_content("Email can't be blank")
      end

      it "My password and password confirmation does not match" do
        visit register_path

        fill_in 'user[username]', with: 'Megan'
        fill_in 'user[email]', with: 'megan@example.com'
        fill_in 'user[password]', with: 'securepassword'
        fill_in 'user[password_confirmation]', with: 'wrongpassword'
        click_button 'Register'

        expect(page).to have_button('Register')
        expect(page).to have_content("Password confirmation doesn't match Password")
      end

      it 'I use a non-unique email' do
        user = create :user

        visit register_path

        fill_in 'user[username]', with: 'Different Megan'
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password
        click_button 'Register'

        expect(page).to have_button('Register')
        expect(page).to have_content("Email has already been taken")
      end

      it 'I use a non-unique username' do
        user = create :user

        visit register_path

        fill_in 'user[username]', with: user.username
        fill_in 'user[email]', with: 'differentemail@email.com'
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password
        click_button 'Register'

        expect(page).to have_button('Register')
        expect(page).to have_content("Username has already been taken")
      end
    end
  end

  describe 'As an authenticated user' do
    describe "When I visit the register page" do
      before :each do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
        visit register_path
      end

      it "I can see a message telling me I'm already registered" do
        expect(page).to have_content("You are already registerd.")
        expect(page).to_not have_button('Register')
        expect(current_path).to eq('/user/dashboard')
      end
    end
  end
end
