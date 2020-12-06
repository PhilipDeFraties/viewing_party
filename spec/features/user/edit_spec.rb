require 'rails_helper'

RSpec.describe 'User edit' do
  describe 'As an authenticated user, when I visit my dashboard page' do
    before(:each) do
      @user_1 = create :user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    end
    
  end
end
