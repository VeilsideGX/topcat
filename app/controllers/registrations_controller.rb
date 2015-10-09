class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, only: :create
      
  def user_details
    @klass = (Object.const_get params[:user_type].classify).new
    html = render_to_string(partial: 'artists/artist_details') if @klass.is_a?Artist
    html = render_to_string(partial: 'bands/band_details') if @klass.is_a?Band
    html = render_to_string(partial: 'clients/client_details') if @klass.is_a?Client
    render json: {html: html }
  end

  def check_email
    result = User.where('email=?', params[:email]).blank?
    render json: result 
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :terms_of_service, :user_type,
                artist_attributes: [:full_name, :zip, :music_genre, :country_id],
                band_attributes: [:band_name, :zip, :music_genre, :country_id],
                client_attributes: [:company_name, :company_email, :official_website, :zip, :country_id]
              )
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :current_password, :profile_pic)
    end
  end

end 