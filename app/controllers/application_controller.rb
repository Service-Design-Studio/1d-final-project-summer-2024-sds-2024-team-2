class ApplicationController < ActionController::Base
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
end
