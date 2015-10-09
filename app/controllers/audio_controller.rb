class AudioController < ApplicationController
  before_action :authenticate_user!

  def index
    @songs = current_account.songs
  end

  def destroy
    song = current_account.songs.find(params[:id])
    song.destroy
    flash[:message]="Song is deleted"
    redirect_to my_songs_path
  end

end
