class Party < ApplicationRecord
  belongs_to :host_id
  belongs_to :movie_id
end
