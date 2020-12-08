class AddDurationToParties < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :duration, :integer
  end
end
