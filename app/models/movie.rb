class Movie < ApplicationRecord
  validates :api_id, uniqueness: true, presence: true, on: :create
  validates :title, presence: true, on: :create

  has_many :parties, dependent: :destroy
end
