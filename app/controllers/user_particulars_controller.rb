# app/controllers/user_particulars_controller.rb
class UserParticularsController < ApplicationController
  include UserParticularsHelper
  before_action :authenticate_user!
  before_action :set_user_particular, only: [:show, :document, :edit, :update, :history]
  before_action :set_ngo_users
  before_action :set_saved_posts

  def show
    logger.debug "Flash check: #{flash[:notice]}"
    @bulletins = Bulletin.all.order(updated_at: :desc)
  end

  def document
    @uploaded_files = @user_particular.uploaded_files
    @back_path = root_path
  end

  def create
    user_particular_temp = UserParticular.new(user_particular_params) # The Model object to store the hidden keyed params

    # Validate user particulars
    error_messages_arr = validate_user_particulars(user_particular_temp)
    flash[:error] = error_messages_arr

    if error_messages_arr.empty?
      @user_particular = UserParticular.create(user_particular_params)

      # Check if user particular creation was successful
      if @user_particular.persisted?
        @user_particular.profile_picture.attach(params[:user_particular][:profile_picture])

        # update user history
        UserHistory.create(
          activity_title: 'Fill in Particulars',
          description: 'User Particulars Updated! Pending verification.',
          activity_type: 'Account',
          user: current_user
        )

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
    session[:user_particular_params] = user_particular_params # Use the session to store the model
    @user_particular = UserParticular.new(user_particular_params) # The Model object to store the hidden keyed params

    # Validate user particulars
    user_particular_errors = validate_user_particulars(@user_particular) || []
    dropdown_errors = validate_user_particulars_dropdown(@user_particular, params[:others]) || []

    error_messages_arr = user_particular_errors + dropdown_errors
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
      @user_particular = UserParticular.find_by(id: params[:id])
    end
  end

  def update
    @user_particular = UserParticular.find(params[:id])
    
    user_particular_errors = validate_user_particulars(@user_particular) || []
    dropdown_errors = validate_user_particulars_dropdown(@user_particular, params[:others]) || []
  
    error_messages_arr = user_particular_errors + dropdown_errors
    flash[:error] = error_messages_arr
    
    # Validate user particulars
    if error_messages_arr.empty?
      if @user_particular.update(user_particular_params)
        if params[:user_particular][:profile_picture].present?
          @user_particular.profile_picture.attach(params[:user_particular][:profile_picture])
        end
  
        @user_particular.update(status: 'pending', verifier_ngo: nil)
        flash[:success] = 'Digital ID was successfully edited!'
        redirect_to @user_particular
      else
        flash[:error_message] = 'Edit failed.'
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

  def generate_2fa
    @user_particular = UserParticular.find_by(id: params[:id])
    @user_particular.generate_2fa_secret
    if @user_particular.save
      respond_to do |format|
        format.json { render json: { two_fa_passcode: @user_particular.two_fa_passcode } }
      end
    else
      render json: { error: 'Failed to generate 2FA passcode' }, status: :unprocessable_entity
    end
  end

  def validate_user_particulars(user_particular)
    error_messages_arr = []

    unless user_particular[:full_name] =~ /^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžæÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$/u
      error_messages_arr << 'Full name can only contain valid letters and symbols.'
    end

    if user_particular[:phone_number] =~ /[^0-9-]/
      error_messages_arr << 'Phone number can only contain numbers and hyphens.'
    end

    if user_particular[:secondary_phone_number] =~ /[^0-9-]/
      error_messages_arr << 'Secondary phone number can only contain numbers and hyphens.'
    end

    if user_particular[:secondary_phone_number_country_code].present? || user_particular[:secondary_phone_number].present?
      if user_particular[:secondary_phone_number_country_code].blank?
        error_messages_arr << 'Secondary country code must exist if secondary phone number exists.'
      end

      if user_particular[:secondary_phone_number].blank?
        error_messages_arr << 'Secondary phone number must exist if secondary country code exists.'
      end
    end

    # Check if selected country is in dropdown options
    unless country_options.include?(user_particular[:country_of_origin])
      error_messages_arr << 'Select country of origin from the dropdown list.'
    end

    if Date.parse(user_particular[:date_of_birth].to_s) > Date.today
      error_messages_arr << 'Date of birth cannot be in the future.'
    end

    if Date.parse(user_particular[:date_of_arrival].to_s) > Date.today
      error_messages_arr << 'Date of arrival cannot be in the future.'
    end

    # Add condition which checks that date of arrival cannot be earlier than date of birth
    if Date.parse(user_particular[:date_of_arrival].to_s) < Date.parse(user_particular[:date_of_birth].to_s)
      error_messages_arr << 'Date of arrival cannot be earlier than date of birth.'
    end

    error_messages_arr
  end

  def validate_user_particulars_dropdown(user_particular, others)
    error_messages_arr = []
    # Check if 'others' is present and that each indiviual field is filled up
    if others.present?
      # Check if others[:ethnicity] is blank
      if user_particular[:ethnicity].blank? && others[:ethnicity].blank?
        error_messages_arr << 'Please specify your ethnicity.'
      # Ensure others[:ethnicity] contains only valid characters
      elsif others[:ethnicity] =~ /[^a-zA-Z-, ]/
        error_messages_arr << 'Ethnicity can only contain letters, hyphens (-), and commas (,).'
      end

      # Check if others[:religion] is blank
      if user_particular[:religion].blank? && others[:religion].blank?
        error_messages_arr << 'Please specify your religion.'
      # Ensure others[:gender] contains only valid characters
      elsif others[:religion] =~ /[^a-zA-Z-, ]/
        error_messages_arr << 'Religion can only contain letters, hyphens (-), and commas (,).'
      end

      # Check if others[:gender] is blank
      if user_particular[:gender].blank? && others[:gender].blank?
        error_messages_arr << 'Please specify your gender.'
      # Ensure others[:gender] contains only valid characters
      elsif others[:gender] =~ /[^a-zA-Z-, ]/
        error_messages_arr << 'Gender can only contain letters, hyphens (-), and commas (,).'
      end

    # If 'others' is not present, check that each individual field is valid
    else
      if user_particular[:ethnicity].blank? || !ethnicity_options.include?(user_particular[:ethnicity])
        error_messages_arr << 'Please select ethnicity from the dropdown list only.'
      end

      if user_particular[:religion].blank? || !religion_options.include?(user_particular[:religion])
        error_messages_arr << 'Please select religion from the dropdown list only.'
      end

      if user_particular[:gender].blank? || !%w[Male Female].include?(user_particular[:gender])
        error_messages_arr << 'Please select gender from the dropdown list only.'
      end
    end

    error_messages_arr
  end

  def saved_post
    logger.debug 'Entering Saved Posts' # Check if the bulletins are being fetched
    @back_path = root_path
    @user_particular = current_user.user_particular
    @bulletins = Bulletin.joins(:saved_posts).where(saved_posts: { user_id: current_user.id })
    logger.debug "Bulletins: #{@bulletins}" # Check if the bulletins are being fetched
    flash[:notice] = 'There are no saved posts!' if @bulletins.empty?
    @on_saved_page = true
  end

  def contact_ngo
    @back_path = user_particular_path
    @user = current_user.user_particular
    @ngo_users = if params[:search].present?
                   NgoUser.joins(:ngo_services)
                          .where('ngo_services.services LIKE ?', "%#{params[:search]}%")
                          .distinct
                 else
                   NgoUser.all
                 end
  end

  def message
    # Access URL parameters
    user_id = params[:id]
    ngo_id = params[:ngoid]
    message_content = params[:message][:content]
    event_title = params[:message][:event_title]
    # Here, you can create a new message or perform other actions, e.g.,
    @message = Message.new(user_id:, ngo_users_id: ngo_id, message: message_content)
    logger.debug @message
    if @message.save
      flash[:notice] = "Message successfully sent to #{NgoUser.find(ngo_id).name}!"
      UserHistory.create(
        activity_title: event_title.blank? ? "Message sent to #{NgoUser.find(ngo_id).name}!" : "#{event_title}: Message sent to #{NgoUser.find(ngo_id).name}!",
        description: "Message: #{message_content}",
        activity_type: 'Message',
        user: current_user
      )
      render json: { success: true, notice: flash[:notice] }
    else
      flash[:alert] = 'Message sending failed.'
      render json: { success: false, alert: flash[:alert] }
    end
  end

  private

  def set_ngo_users
    @ngo_users = NgoUser.all
    @user = current_user
  end

  def set_saved_posts
    @saved_posts = current_user.saved_posts.pluck(:bulletin_id)
  end
end
