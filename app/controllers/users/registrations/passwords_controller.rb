# frozen_string_literal: true

class Users::Registrations::PasswordsController < Devise::PasswordsController
  def create
    self.resource = if params[:user][:email].present?
                      resource_class.find_by(email: params[:user][:email])
                    elsif params[:user][:phone_number].present?
                      resource_class.find_by(phone_number: params[:user][:phone_number])
                    else
                      nil
                    end

    if resource.present?
      resource.send_reset_password_instructions
      yield resource if block_given?

      if successfully_sent?(resource)
        respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
      else
        respond_with(resource)
      end
    else
      flash[:alert] = 'Email or phone number not found'
      respond_with(resource, location: new_password_path(resource_name))
    end
  end

  protected

  def resource_params
    params.require(resource_name).permit(:email, :phone_number)
  end
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
