class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update
    user = current_user
    user.update_attributes(profile_pic: user_params["profile_pic"])
    redirect_to user_path(current_user)
  end

  def audio
    user = current_user.artist? ? current_artist : current_band
    songlist = {}
    user.songs.map{|song| songlist.merge!(song.audio_file.url => song.audio_file_file_name )}
    @songlist = songlist
  end

  def video
    user = current_user.artist? ? current_artist : current_band
    @videos = user.videos
    @video = Video.new
  end

  def upload_video
    user = current_user.artist? ? current_artist : current_band
    @video = user.videos.new( video_params)
    video_info = VideoInfo.new(video_params[:video_url])
    if video_info.available?
       @video.video_image_url = video_info.thumbnail_medium 
      if @video.save
        flash[:message] = "Uploaded url"
        redirect_to artist_video_path(user)
      else
        flash[:error] = "Error: #{@video.errors.full_messages.join(", ")}"
        render "video"
      end
    else
      flash[:Error] = "Uploaded url is not available."
      redirect_to artist_video_path(user)
    end
  end

  def upload_audio
    if current_user.artist? or current_user.band?
      if current_user.artist?
        song = current_artist.songs.new(audio_params)
      else
        song = current_band.songs.new(audio_params)
      end
      if song.save
        flash[:message] = "song has been uploaded. It will appear in your list after approve by our staff."
      else
        flash[:error] = song.errors.full_messages.join("<br/>")
      end
      redirect_to artist_audio_path(current_user)
    end
  end
  
  def email_list
    suggestions = User.where("email ilike ? and user_type in (?)", "#{params[:query]}%", [1,2]).limit(5)
    render json: {suggestions: suggestions}
  end

  private

  def user_params
    params.require(:user).permit(:profile_pic, :audio_file)
  end

  def audio_params
    params.require(:user).permit(:audio_file)
  end

  def video_params
    params.require(:video).permit(:video_url, :video_image_url)
  end
  
end
