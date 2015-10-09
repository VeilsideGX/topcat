class AddFieldsToSongsAndVideos < ActiveRecord::Migration
  def change
    add_column :songs, :is_approved, :boolean, default: false
    add_column :videos, :is_approved, :boolean, default: false
  end
end
