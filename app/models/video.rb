class Video < ActiveRecord::Base
  belongs_to :videoable, :polymorphic => true
  validates_presence_of :video_url
  
  
    def self.approve_unapprove_video(video_id)
      videos = Video.where("id in(?)", video_id)
      videos.each do |video|
        video.update_attributes(is_approved: !video.is_approved)
      end  
    end

end
