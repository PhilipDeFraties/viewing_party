class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :runtime
      t.integer :api_id
      t.string :logo

      t.timestamps
    end
  end
end
