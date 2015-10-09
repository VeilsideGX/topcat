ActiveAdmin.register Video do
  
  actions :all, except: [:new, :show, :create, :edit, :updated]
  
  
  index do
    column :id
    column "Email" do |video|
      link_to video.videoable.user.email, admin_user_path(video.videoable_id)
    end
    column "User Type" do |video|
      video.videoable_type.capitalize
    end
    column "Url" do |video|
      video.video_url
    end
    column :created_at
    column "Approved?" do |video|
      status_and_class = video.is_approved ? "Yes" : "No"
      content_tag :span, status_and_class, class: "status_tag #{status_and_class.downcase}"
    end
    actions do |video|
      status = video.is_approved ? "Unapproved" : "Approved"
      link_to status, approve_admin_video_path(video)
    end
  end
  
  member_action :approve do
    Video.approve_unapprove_video([params[:id]])
    redirect_to admin_videos_path, notice: 'Video has been updated'
  end


end
