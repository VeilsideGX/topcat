class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :full_name
      t.string :music_genre
      t.string :country_id
      t.string :zip
      t.integer :user_id
      t.timestamps
    end
  end
end
