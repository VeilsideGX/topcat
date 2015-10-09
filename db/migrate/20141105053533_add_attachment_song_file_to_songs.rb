class AddAttachmentSongFileToSongs < ActiveRecord::Migration
  def self.up
    change_table :songs do |t|
      t.attachment :audio_file
    end
  end

  def self.down
    remove_attachment :songs, :audio_file
  end
end
