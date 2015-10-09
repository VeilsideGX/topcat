class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :songable_id
      t.string  :songable_type
      t.timestamps
    end
  end
end
