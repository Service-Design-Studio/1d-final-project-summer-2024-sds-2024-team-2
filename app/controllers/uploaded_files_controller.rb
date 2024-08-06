class UploadedFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_particular

  def index
    @uploaded_files = @user_particular.uploaded_files
    render json: @uploaded_files
  rescue => e
    logger.error "Error in index action: #{e.message}"
    render json: { success: false, errors: ["Failed to load uploaded files"] }, status: :internal_server_error
  end

  def create
    @uploaded_file = @user_particular.uploaded_files.build(uploaded_file_params)
    @uploaded_file.status = 'Unverified'
    @uploaded_file.document_type = 'Education'
    @uploaded_file.description = 'Enter your description'
    @uploaded_file.user_id = current_user.id

    if @uploaded_file.save
      if params[:uploaded_file][:file_path].present?
        @uploaded_file.file_path.attach(params[:uploaded_file][:file_path])
        render json: { success: true, file: @uploaded_file.as_json.merge({ file_url: url_for(@uploaded_file.file_path) }) }, status: :created
      else
        @uploaded_file.destroy
        render json: { success: false, errors: ["File path is missing"] }, status: :unprocessable_entity
      end
    else
      render json: { success: false, errors: @uploaded_file.errors.full_messages }, status: :unprocessable_entity
    end
  rescue => e
    logger.error "Failed to upload file: #{e.message}"
    render json: { success: false, errors: ["Failed to upload file"] }, status: :internal_server_error
  end

  private

  def set_user_particular
    @user_particular = UserParticular.find(params[:user_particular_id])
  rescue ActiveRecord::RecordNotFound => e
    logger.error "UserParticular not found: #{e.message}"
    render json: { success: false, errors: ["UserParticular not found"] }, status: :not_found
  end

  def uploaded_file_params
    params.require(:uploaded_file).permit(:file_path, :name, :file_type, :file_size, :description, :document_type, :status)
  end
end
