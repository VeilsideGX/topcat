class ClientsController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = current_artist
    if @user.update_attributes(client_params)
      flash[:message] = "profile informatio is updated"
      redirect_to user_path(@user)
    else
      flash[:error] = @user.errors.full_messages.join("<br/>")
      render 'users/edit'
    end
  end

  private
  
  def client_params
    params.require(:band).permit(:company_name, :company_email, :official_website, :zip, :country_id)
  end

end
