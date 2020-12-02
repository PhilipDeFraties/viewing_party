class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true
  validates :username, uniqueness: true

  validates :username, :email, presence: { require: true }

  validates :password, presence: true, on: :create

  validates :password, confirmation: { case_sensitive: true }
  validates :password_confirmation, presence: true, on: :create

  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
  
  has_many :parties
  
  def find_parties
    parties = Party.where(user_id: self.id).or(Party.where(id: PartyGuest.where(user_id: self.id).pluck(:party_id)))
  end
end
