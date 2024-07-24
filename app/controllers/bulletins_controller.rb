class BulletinsController < ApplicationController
  def index
    @bulletins = Bulletin.all
    @ngo_users = NgoUser.all
  end

  def update
  end

  def create
    @bulletin = Bulletin.new(bulletin_params)
    if @bulletin.save
      flash[:success] = "Post added successfully."
      redirect_to bulletins_path # Adjust the redirect path as needed
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
