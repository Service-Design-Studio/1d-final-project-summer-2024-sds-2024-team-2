class UserParticularsController < ApplicationController
  include UserParticularsHelper

  before_action :set_user_particular, only: [:show, :edit, :update, :confirm]

  def show; end

  def create
    @user_particular = UserParticular.new(user_particular_params)
    if validate_user_particulars(@user_particular)
      if @user_particular.save
        flash[:success] = 'Digital ID was successfully created!'
        redirect_to @user_particular # redirects to /user_particulars/:id
      else
        flash[:error] = ['Error creating digital ID']
        render :new
      end
    else
      flash[:error] ||= []
      flash[:error] << 'Validation failed for user particulars'
      render :new
    end
  end

  def new
    @user_particular = UserParticular.new(session[:user_particular_params] || {})
    set_dropdown_options
  end

  def confirm
    @user_particular = UserParticular.new(user_particular_params)
    if validate_user_particulars(@user_particular)
      session[:user_particular_params] = user_particular_params
      render :confirm
    else
      flash[:error] ||= []
      flash[:error] << 'Validation failed for user particulars'
      render :new
    end
  end

  def edit
    set_dropdown_options
  end

  def update
    if @user_particular.update(user_particular_params)
      flash[:success] = 'User particulars were successfully updated.'
      redirect_to @user_particular
    else
      flash[:error] = 'Failed to update user particulars.'
      render :edit
    end
  end

  private

  def set_user_particular
    @user_particular = UserParticular.find(params[:id])
  end

  def user_particular_params
    params.require(:user_particular).permit(:full_name, :phone_number, :secondary_phone_number, :country_of_origin,
                                            :ethnicity, :religion, :gender, :date_of_birth, :date_of_arrival_in_malaysia)
  end

  def set_dropdown_options
    @countries = country_options
    @ethnicities = ethnicity_options
    @religions = religion_options
  end

  def validate_user_particulars(user_particular)
    error_messages_arr = []

    unless user_particular.full_name =~ /^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžæÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$/u
      error_messages_arr << 'Full name can only contain valid letters and symbols.'
    end

    error_messages_arr << 'Phone number cannot contain letters.' if user_particular.phone_number =~ /[a-zA-Z]/
    error_messages_arr << 'Secondary phone number cannot contain letters.' if user_particular.secondary_phone_number =~ /[a-zA-Z]/

    unless user_particular.country_of_origin.in? country_options
      error_messages_arr << 'Select country of origin from the dropdown list.'
    end

    unless user_particular.ethnicity.in? ethnicity_options
      error_messages_arr << 'Select ethnicity from the dropdown list.'
    end

    unless user_particular.religion.in? religion_options
      error_messages_arr << 'Select religion from the dropdown list.'
    end

    if user_particular.date_of_birth > Date.today
      error_messages_arr << 'Date of birth cannot be in the future.'
    end

    if user_particular.date_of_arrival_in_malaysia > Date.today
      error_messages_arr << 'Date of arrival in Malaysia cannot be in the future.'
    end

    flash[:error] = error_messages_arr

    error_messages_arr.empty?
  end
end
