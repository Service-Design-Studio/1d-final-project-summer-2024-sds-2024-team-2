# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?
  layout :layout_by_resource
  # render different base layout based on requesting controller
  def layout_by_resource
    if controller_name == 'ngo_users'
      'ngo'
    # render application layout if user signed in, if not render userlogin layout  
    else
      user_signed_in? ? 'application' : 'userlogin'
    end
  end
end
