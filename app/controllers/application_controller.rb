class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_client, :current_artist, :current_band, :current_account
  before_filter :check_user_assign, if: :user_signed_in?

  def check_user_assign
    result = current_user.not_assign?
    if result and params[:controller] != 'devise/sessions'
      redirect_to root_path, notice: 'Your account is not complete. Please contact support'
    end      
  end

  def after_sign_in_path_for(resource)
    edit_user_path(current_user)
  end

  def current_client
    current_user.client
  end

  def current_artist
    current_user.artist
  end

  def current_band
    current_user.band
  end
  
  def current_account
    current_user.client || current_user.artist || current_user.band
  end
end