class Party < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_many :party_guests, dependent: :destroy
  has_many :users, through: :party_guests
  # validates_length_of :date, :is => 10

  def user_status(user_id)
    if self.user_id == user_id
      'Host'
    else
      'Invited'
    end
  end

  def invite_friends(party_guests)
    party_guests.reject! { |pg| pg.empty? }
    party_guests.each do |guest|
      self.party_guests.create(user_id: guest.to_i)
    end
  end
end
