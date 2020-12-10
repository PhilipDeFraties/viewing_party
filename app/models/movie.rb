class Movie < ApplicationRecord
  validates :api_id, uniqueness: true, presence: true, on: :create
  validates :title, presence: true, on: :create

  has_many :parties, dependent: :destroy

  def self.check_db(api_id, movie_params)
    Movie.find_by(api_id: api_id) || Movie.create!(movie_params)
  end
end
