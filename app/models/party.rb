class Party < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_many :party_guests
  has_many :users, through: :party_guests

  def user_status(user_id)
    if self.user_id == user_id
      'Host'
    else
      'Invited'
    end
  end
end
