class NgoUsersController < ApplicationController
  def new
  end

  def show
    @ngo_user = NgoUser.find(params[:id])
    # The rest of your show method logic here
  end

  def index
  end

  def verify
  end
end
