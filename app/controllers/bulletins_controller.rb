class BulletinsController < ApplicationController
  # def index
  #   @bulletins = Bulletin.all
  #   @ngo_users = NgoUser.all
  # end

  # def update
  # end

  def create
    logger.debug "User ID: #{params[:user_id]}"
    @ngo_user = NgoUser.find(params[:bulletin][:user_id])
    @bulletin = Bulletin.new(bulletin_params)
    uploaded_io = params[:bulletin][:photo]

    uploads_dir = Rails.root.join('public', 'uploads')
    FileUtils.mkdir_p(uploads_dir) unless File.directory?(uploads_dir)

    if uploaded_io.present?
      file_path = uploads_dir.join(uploaded_io.original_filename)
      File.open(file_path, 'wb') do |file|
        file.write(uploaded_io.read)
      end
      @bulletin.photo = uploaded_io.original_filename
    else
      @bulletin.photo = @ngo_user.image_url # Use the NGO image URL if no file is uploaded
    end
    
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
    params.require(:bulletin).permit(:title, :description, :date, :location, :ngo_name, :photo)
  end
end
