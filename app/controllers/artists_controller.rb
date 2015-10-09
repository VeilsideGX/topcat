class ArtistsController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = current_artist
    if @user.update_attributes(artist_params)
      flash[:message] = "profile informatio is updated"
      redirect_to user_path(@user)
    else
      flash[:error] = @user.errors.full_messages.join("<br/>")
      render 'users/edit'
    end
  end

  private
  
  def artist_params
    params.require(:artist).permit(:full_name, :country_id, :zip, :music_genre)
  end

end
