class NgoUsersController < ApplicationController
  before_action :set_ngo_page_true
  def new
  end

  def show
    @back_path = ngo_users_path
    @ngo_user = NgoUser.find(params[:id])
    nil unless params[:unique_id].present?
    @ngo_users = NgoUser.all
    @bulletins = Bulletin.all.order(updated_at: :desc) # Ensures @bulletins is an array even if the query finds no records for NIL posts in bulletin board
    logger.debug "Bulletins: #{@bulletins}"
    @show_add_bulletin_button = true
    @saved_posts = current_user&.saved_posts || [] # Ensure @saved_posts is not nil
  end

  def index
    @back_path = new_user_session_path
    @ngo_users = if params[:search].present?
                   NgoUser.where('name LIKE ?', "%#{params[:search]}%")
                 else
                   NgoUser.all
                 end
  end

  def check_user
    @back_path = ngo_users_path
    @ngo_user = NgoUser.find(params[:id])
    @user_particular = UserParticular.find_by(unique_id: params[:unique_id], two_fa_passcode: params[:two_fa_passcode])

    if @user_particular
      redirect_to verify_ngo_user_path(@ngo_user, unique_id: @user_particular.unique_id)
    else
      flash[:alert] = 'User not found. Please check your Unique ID and 2FA Code.'
      redirect_to ngo_user_path(@ngo_user.id, modal: 'check_user')
    end
  end

  def verify
    @back_path = ngo_user_path
    @ngo_user = NgoUser.find(params[:id])
    @user_particular = UserParticular.find_by(unique_id: params[:unique_id])
  end

  def confirm_verify
    @back_path = ngo_user_path
    @ngo_user = NgoUser.find(params[:id])
    @user_particular = UserParticular.find_by(unique_id: params[:unique_id])
    @user_particular.update(status: 'verified', verifier_ngo: @ngo_user.name) # Update the status to 'verified'

    # update user history
    UserHistory.create(
      activity_title: "User Particulars verified by #{@ngo_user.name}",
      description: 'Now, other NGOs would be able to recognise your need for support and services.',
      activity_type: 'Account',
      user: User.find_by(id: @user_particular.user_id)
    )

    flash[:success] = "Verification successful for unique ID: #{@user_particular.unique_id}."
    redirect_to ngo_user_path(@ngo_user), status: :found
  end

  def set_ngo_page_true
    @ngo_page = true
  end

  def inbox
    @back_path = ngo_user_path
    @ngo_user = NgoUser.find(params[:id])
    @messages = Message.all_received_messages(@ngo_user.id)
  end

  def interaction_history
    @back_path = ngo_user_path
    @ngo_user = NgoUser.find(params[:id])
    @interaction_history = InteractionHistory.where(ngo_user_id: @ngo_user.id)
    render 'interaction_history'
  end
end
