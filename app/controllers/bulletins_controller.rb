class BulletinsController < ApplicationController
  # def index
  #   @bulletins = Bulletin.all
  #   @ngo_users = NgoUser.all
  # end

  # def update
  # end

  def create
    logger.debug "User ID: #{params[:user_id]}"
    @ngo_user = NgoUser.find_by_id(params[:bulletin][:user_id])
    @bulletin = Bulletin.new(bulletin_params)
    if @bulletin.save
      flash[:success] = "Post added successfully."
      redirect_to ngo_user_path(@ngo_user.id) # Adjust the redirect path as needed
    else
      flash[:error] = "Failed to add post."
      render :index
    end
  end
  
  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :date, :location, :ngo_name)
  end
end
