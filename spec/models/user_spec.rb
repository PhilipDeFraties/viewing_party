require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it { should validate_uniqueness_of :email }
    it { should validate_uniqueness_of :username }

    it { should validate_presence_of :email }
    it { should validate_presence_of :username }
    it { should validate_presence_of :password }
    it { should validate_presence_of :password_confirmation }
  end

  describe "relationships" do
    it { should have_many :friendships }
    it { should have_many :parties }
  end

  it ".find_parties" do
    user_1 = create :user
    user_2 = create :user
    movie_1 = create :movie
    movie_2 = create :movie
    party_1 = Party.create!(user_id: user_1.id, movie_id: movie_1.id, date: '12-24-2020', time: '9:30', duration: 130)
    party_2 = Party.create!(user_id: user_2.id, movie_id: movie_2.id, date: '12-19-2020', time: '4:30', duration: 142)
    party_3 = Party.create!(user_id: user_2.id, movie_id: movie_2.id, date: '12-19-2020', time: '4:30', duration: 160)
    PartyGuest.create!(user_id: user_1.id, party_id: party_2.id)

    expect(user_1.find_parties).to eq([party_1, party_2])
    expect(user_1.find_parties).to_not include(party_3)
  end

  it ".create_friendships" do
    user_1 = create :user
    user_2 = create :user

    user_1.create_friendships(user_1.id, user_2.id)

    expect(user_1.friends).to include(user_2)
    expect(user_2.friends).to include(user_1)
  end
end
