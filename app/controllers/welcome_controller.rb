class WelcomeController < ApplicationController
  skip_before_filter :check_user_assign, :only => :index
  
  def index
  end
end
