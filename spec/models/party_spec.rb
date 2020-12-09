require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'validations' do
    it { should validate_presence_of :user_id}
    it { should validate_presence_of :time}
    # it { should validate_presence_of :date}
    it {should validate_numericality_of(:duration).is_greater_than(0)}
  end

  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :movie}
    it {should have_many :party_guests}
    it {should have_many(:users).through(:party_guests)}
  end

  describe 'instance methods' do
    it ".user-status" do
      user_1 = create :user
      user_2 = create :user
      user_3 = create :user
      movie_1 = create :movie
      Friendship.create!(user_id: user_1.id, friend_id: user_2.id)
      party_1 = user_1.parties.create!(movie_id: movie_1.id, date: Date.today.strftime('%m/%d/%Y'), time: '9:30', duration: 142)
      party_1.invite_friends(["", user_2.id, user_3.id])
      pg = party_1.party_guests.map { |guest| guest.user }
      expect(pg).to eq([user_2, user_3])
    end

    it ".invite_friends" do
      user_1 = create :user
      user_2 = create :user
      user_3 = create :user
      movie_1 = create :movie
      Friendship.create!(user_id: user_1.id, friend_id: user_2.id)
      party_1 = user_1.parties.create!(movie_id: movie_1.id, date: Date.today.strftime('%m/%d/%Y'), time: '9:30', duration: 142)
      expect(party_1.user_status(user_1.id)).to eq('Host')
    end

    it ".new_party" do
      user = create :user
      party_params = {date: "12-08-2020", time: "08:00 PM", duration: "180"}
      movie = create :movie
      party = Party.new_party(user.id, party_params, movie.id)

      expect(party.class).to eq(Party)
      expect(party.user).to eq(user)
      expect(party.movie).to eq(movie)
      expect(party.date).to eq(party_params[:date])
      expect(party.time).to eq(party_params[:time])
      expect(party.duration).to eq(party_params[:duration].to_i)
    end
  end
end
