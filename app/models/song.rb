class Song < ActiveRecord::Base
  belongs_to :songable, :polymorphic => true

  has_attached_file :audio_file

  validates_attachment_presence :audio_file

  validates_attachment_content_type :audio_file,
                                    :content_type => [ 'audio/mpeg', 'audio/mp3',
                                                       "audio/wav", "audio/x-wav",
                                                       "audio/aiff"]

  validates_attachment_size :audio_file, :less_than => 5.megabytes
  
end

#http://stackoverflow.com/questions/10134927/playing-song-in-jplayer-that-was-uploaded-via-paperclip-ruby-on-rails-jquery
