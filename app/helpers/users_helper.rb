module UsersHelper

  def text_user_info
    return current_user.artist_full_name if current_user.artist?
    return current_user.band_name if current_user.band?
    return current_user.client_company_name if current_user.client?
  end

end
