# app/controllers/user_particulars_controller.rb
class UserParticularsController < ApplicationController
  include UserParticularsHelper
  before_action :authenticate_user!
  before_action :set_user_particular
  before_action :set_ngo_users
  before_action :set_saved_posts

  def show
    @bulletins = Bulletin.all.order(updated_at: :desc)
  end

  def document
    @uploaded_files = @user_particular.uploaded_files
    @back_path = root_path
  end

  def create
    error_messages_arr = validate_user_particulars(UserParticular.new(user_particular_params))
    flash[:error] = error_messages_arr

    if error_messages_arr.empty?
      @user_particular = UserParticular.create_user_particular(user_particular_params)
      if @user_particular.persisted?
        @user_particular.profile_picture.attach(params[:user_particular][:profile_picture])
        flash[:success] = 'Digital ID was successfully created!'
        redirect_to @user_particular
      else
        flash[:error_message] = 'Digital ID creation failed. Please try again.'
        redirect_to user_particulars_confirm_path(user_particular: user_particular_params)
      end
    else
      flash[:error_message] = 'Digital ID creation failed. Please try again.'
      redirect_to user_particulars_confirm_path(user_particular: user_particular_params)
    end
  end

  def new
    @back_path = root_path
    @user_particular = if session[:user_particular_params].present?
                         UserParticular.new(session[:user_particular_params])
                       else
                         UserParticular.new
                       end

    set_dropdown_options
  end

  def confirm
    session[:user_particular_params] = user_particular_params
    @user_particular = UserParticular.new(user_particular_params)
    error_messages_arr = validate_user_particulars(@user_particular)
    flash[:error] = error_messages_arr

    if error_messages_arr.empty?
      render :confirm
    else
      flash[:error_message] = 'Please fix the error(s) below:'
      redirect_to new_user_particular_path
    end
  end

  def edit
    @back_path = root_path
    set_dropdown_options

    if params[:user_particular]
      @user_particular = UserParticular.new(user_particular_params)
      @user_particular.id = params[:id]
    else
      @user_particular = UserParticular.find(params[:id])
    end
  end

  def update
    error_messages_arr = validate_user_particulars(UserParticular.new(user_particular_params))
    flash[:error] = error_messages_arr

    if error_messages_arr.empty?
      @user_particular = UserParticular.update_user_particular(params[:id], user_particular_params)
      if @user_particular
        flash[:success] = 'Digital ID was successfully edited!'
        UserParticular.reset_verification(params[:id])
        redirect_to @user_particular
      else
        flash[:error_message] = 'Edit failed. Please fix the error(s) below:'
        redirect_to edit_user_particular_path(params[:id], user_particular: user_particular_params)
      end
    else
      flash[:error_message] = 'Edit failed. Please fix the error(s) below:'
      redirect_to edit_user_particular_path(params[:id], user_particular: user_particular_params)
    end
  end

  def history
    @back_path = root_path
    @user_history = UserHistory.where(user_id: params[:id]).order(updated_at: :desc)
  end

  private

  def set_user_particular
    @user_particular = current_user.user_particular
  end

  def user_particular_params
    params.require(:user_particular).permit(:full_name, :phone_number, :secondary_phone_number, :country_of_origin,
                                            :ethnicity, :religion, :gender, :date_of_birth, :date_of_arrival,
                                            :photo_url, :birth_certificate_url, :passport_url, :user_id,
                                            :phone_number_country_code, :secondary_phone_number_country_code,
                                            :full_phone_number, :full_secondary_phone_number, :status, :profile_picture).tap do |whitelisted|
      if whitelisted[:ethnicity] == 'Others' && params[:others].present?
        whitelisted[:ethnicity] = params[:others][:ethnicity]
      end
      if whitelisted[:religion] == 'Others' && params[:others].present?
        whitelisted[:religion] = params[:others][:religion]
      end
      whitelisted[:gender] = params[:others][:gender] if whitelisted[:gender] == 'Others' && params[:others].present?
    end
  end

  def set_dropdown_options
    @countries = country_options
    @ethnicities = ethnicity_options
    @religions = religion_options
    @country_code_options = country_code_options
  end

  def set_ngo_users
    @ngo_users = NgoUser.all
    @user = current_user
  end

  def set_saved_posts
    @saved_posts = current_user.saved_posts.pluck(:bulletin_id)
  end
end
