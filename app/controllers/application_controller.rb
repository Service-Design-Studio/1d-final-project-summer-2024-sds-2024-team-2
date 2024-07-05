# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?
  layout :layout_by_resource
  def layout_by_resource
    if controller_name == 'ngo_users'
      'ngo'
    else
      user_signed_in? ? 'application' : 'userlogin'
    end
  end
end
