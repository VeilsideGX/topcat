class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :band_name
      t.string :music_genre
      t.string :country_id
      t.string :zip
      t.integer :user_id
      t.timestamps
    end
  end
end
