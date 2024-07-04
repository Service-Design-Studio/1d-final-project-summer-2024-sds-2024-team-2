class ApplicationController < ActionController::Base
<<<<<<< HEAD
  # Before any action in Devise controllers, configure permitted parameters
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Configure additional parameters for Devise
  def configure_permitted_parameters
    # Permit the additional sign-up parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :phone_number])

    # Permit the additional account update parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :phone_number])
  end

  # Redirect to user particulars path after sign-in
  def after_sign_in_path_for(resource)
    if resource.user_particular.present?
      user_particular_path(resource.user_particular)
    else
      new_user_particular_path # Redirect to the new user particular creation page
    end
=======
  before_action :authenticate_user! # This will ensure that a user is logged in before accessing any page
  helper_method :current_user, :user_signed_in?
  layout :layout_by_resource
  def layout_by_resource
    user_signed_in? ? 'application' : 'userlogin'
>>>>>>> development
  end
end
