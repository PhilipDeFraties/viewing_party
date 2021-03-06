class Party < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_many :party_guests, dependent: :destroy
  has_many :users, through: :party_guests
  validates :user_id, presence: true
  validates :time, presence: true
  validates :date, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }

  def user_status(user_id)
    if self.user_id == user_id
      'Host'
    else
      'Invited'
    end
  end

  def invite_friends(party_guests)
    party_guests.delete_at(0)
    party_guests.each do |guest|
      self.party_guests.create(user_id: guest.to_i)
    end
  end

  def self.new_party(user_id, party_params, movie_id)
    create(
      user_id: user_id,
      date: party_params[:date],
      time: party_params[:time],
      duration: party_params[:duration],
      movie_id: movie_id
    )
  end
end
