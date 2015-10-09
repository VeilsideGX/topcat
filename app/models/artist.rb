class Artist < ActiveRecord::Base
  belongs_to :user
  has_many :songs, as: :songable
  has_many :videos, as: :videoable
  
  validates :full_name, :zip, :music_genre, :country_id, presence: true

  after_create :assign_role

  def approved_videos
    self.videos.where("is_approved=?", true)    
  end

  def approved_songs
    self.songs.where("is_approved=?", true)    
  end

  protected

  def assign_role
    user = self.user
    user.user_type = 1
    user.save
  end

end
