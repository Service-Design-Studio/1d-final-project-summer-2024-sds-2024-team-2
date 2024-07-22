class BulletinsController < ApplicationController
  def index
    @bulletins = Bulletin.all
    @ngo_users = NgoUser.all
  end

  def update
  end
end
