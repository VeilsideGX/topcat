class VideosController < ApplicationController
  before_action :authenticate_user!

  def index
    @videos = current_account.videos
    @profile_page = true
  end

  def destroy
    video = current_account.videos.find(params[:id])
    video.destroy
    flash[:message]="Video is deleted"
    redirect_to videos_path
  end

end
