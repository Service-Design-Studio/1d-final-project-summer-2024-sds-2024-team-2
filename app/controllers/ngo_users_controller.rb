class NgoUsersController < ApplicationController
  def new
  end

  def show
    
    @ngo_user = NgoUser.find(params[:id])
    return unless params[:unique_id].present?

    @user_particular = UserParticular.find_by(unique_id: params[:unique_id])
    if @user_particular
      flash.now[:notice] = 'Unique ID found. Please enter your 2FA code.'
      @unique_id_exists = true
    else
      flash[:alert] = 'Unique ID does not exist. Please try again.'
      @unique_id_exists = false
    end
    @back_path = ngo_users_path
  end

  def index
    # @ngo_users = NgoUser.all
    if params[:search].present?
      @ngo_users = NgoUser.where("name LIKE ?", "%#{params[:search]}%")
    else
      @ngo_users = NgoUser.all
    end
    @back_path = new_user_session_path
  end

  def check_user
    @ngo_user = NgoUser.find(params[:id])
    @user_particular = UserParticular.find_by(unique_id: params[:unique_id], two_fa_passcode: params[:two_fa_passcode])
    logger.debug "User Particular: #{@user_particular}"
    if @user_particular
      flash.now[:notice] = 'User found.'
      @checked = true
      @unique_id_exists = true
      params[:unique_id] = @user_particular.unique_id
      logger.debug "params[:unique_id]: #{params[:unique_id]}"
      redirect_to verify_ngo_user_path(@ngo_user, unique_id: @user_particular.unique_id) # Yiqing redirect to verify code
    else
      flash[:alert] = 'User not found.'
      @checked = false
      @unique_id_exists = true
    end
  end

  def verify
    
    @ngo_user = NgoUser.find(params[:id])
    logger.debug "params[:unique_id]: #{params[:unique_id]}"
    @user_particular = UserParticular.find_by(unique_id: params[:unique_id])
    logger.debug "User Particular: #{@user_particular}"
    # Any additional logic you want to include before rendering the verify view
    # render 'verify' is implicit
    #flash[:notice] = "Verification successful."
    
    @back_path = ngo_user_path
    #redirect_to ngo_user_path(@ngo_user, id: params[:id], commit:'Verify')
  end

  def confirm_verify
    @ngo_user = NgoUser.find(params[:id])
    @user_particular = UserParticular.find_by(unique_id: params[:unique_id])
    # Add any verification logic here
    #redirect_to "http://localhost:3000/ngo_users/:id"
    flash[:confirm_verify_notice] = "Verification successful for unique ID: #{@user_particular.unique_id}."
    redirect_to ngo_user_path(@ngo_user), status: :found
  end
end
