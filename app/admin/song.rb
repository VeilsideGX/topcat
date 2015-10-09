ActiveAdmin.register Song do

actions :all, except: [:new, :show, :create, :edit, :update]
  
  index do
    column :id
    column "Email" do |song|
      song.songable.user.email
    end
    column "User Type" do |song|
      song.songable_type.capitalize
    end
    column "Audio File" do |song|
      content_tag(:audio, content_tag(:source, '', src: song.audio_file, type: 'audio/mpeg'), controls: '')
    end
    column :created_at
    column "Approved?" do |song|
      status_and_class = song.is_approved ? "Yes" : "No"
      content_tag :span, status_and_class, class: "status_tag #{status_and_class.downcase}"
    end
    actions do |song|
      status = song.is_approved ? "Unapproved" : "Approved"
      link_to status, approve_admin_song_path(song)
    end
  end
  
  member_action :approve do
    Song.approve_unapprove_song([params[:id]])
    redirect_to admin_songs_path, notice: 'Song has been updated'
  end
  


end
