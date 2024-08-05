class UploadedFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_particular

  def index
    @uploaded_files = @user_particular.uploaded_files
    render json: @uploaded_files
  end

  def create
    @uploaded_file = @user_particular.uploaded_files.build(uploaded_file_params)
    @uploaded_file.status = 'Unverified' if @uploaded_file.status.blank?
    @uploaded_file.user_id = current_user.id

    if @uploaded_file.save
      render json: { success: true, file: @uploaded_file.as_json.merge({ file_url: @uploaded_file.file_url }) }, status: :created
    else
      render json: { success: false, errors: @uploaded_file.errors.full_messages }, status: :unprocessable_entity
    end
  rescue => e
    logger.error "Failed to upload file: #{e.message}"
    render json: { success: false, errors: ["Failed to upload file"] }, status: :internal_server_error
  end

  def destroy
    @uploaded_file = @user_particular.uploaded_files.find(params[:id])
    @uploaded_file.destroy
    head :no_content
  end

  def update
    @uploaded_file = @user_particular.uploaded_files.find(params[:id])
    if @uploaded_file.update(uploaded_file_params)
      render json: { success: true, file: @uploaded_file }
    else
      render json: { success: false, errors: @uploaded_file.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user_particular
    @user_particular = UserParticular.find(params[:user_particular_id])
  end

  def uploaded_file_params
    params.require(:uploaded_file).permit(:file_path, :name, :file_type, :file_size, :description, :document_type, :status)
  end
end
