class UploadedFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_particular
  before_action :set_uploaded_file, only: [:destroy, :update]

  def index
    @uploaded_files = @user_particular.uploaded_files
    render json: @uploaded_files.map { |file| file.as_json.merge(file_path: url_for(file.file_path)) }
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
    @uploaded_file.upload_date = Time.current

    if params[:uploaded_file][:file_path].present?
      @uploaded_file.file_path.attach(params[:uploaded_file][:file_path])
      if @uploaded_file.save
        render json: { success: true, file: @uploaded_file.as_json.merge({ file_url: @uploaded_file.file_url }) }, status: :created
      else
        render json: { success: false, errors: @uploaded_file.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { success: false, errors: ["File path is missing"] }, status: :unprocessable_entity
    end
  rescue => e
    logger.error "Failed to upload file: #{e.message}"
    render json: { success: false, errors: ["Failed to upload file"] }, status: :internal_server_error
  end

  def update
    if @uploaded_file.update(uploaded_file_params)
      render json: { success: true, file: @uploaded_file }, status: :ok
    else
      render json: { success: false, errors: @uploaded_file.errors.full_messages }, status: :unprocessable_entity
    end
  rescue => e
    logger.error "Failed to update file: #{e.message}"
    render json: { success: false, errors: ["Failed to update file"] }, status: :internal_server_error
  end

  def destroy
    if @uploaded_file.file_path.purge && @uploaded_file.destroy
      render json: { success: true, message: "File deleted successfully" }, status: :ok
    else
      render json: { success: false, errors: ["Failed to delete file"] }, status: :unprocessable_entity
    end
  rescue => e
    logger.error "Failed to delete file: #{e.message}"
    render json: { success: false, errors: ["Failed to delete file"] }, status: :internal_server_error
  end

  private

  def set_user_particular
    @user_particular = UserParticular.find(params[:user_particular_id])
  rescue ActiveRecord::RecordNotFound => e
    logger.error "UserParticular not found: #{e.message}"
    render json: { success: false, errors: ["UserParticular not found"] }, status: :not_found
  end

  def set_uploaded_file
    @uploaded_file = @user_particular.uploaded_files.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    logger.error "UploadedFile not found: #{e.message}"
    render json: { success: false, errors: ["UploadedFile not found"] }, status: :not_found
  end

  def uploaded_file_params
    params.require(:uploaded_file).permit(:file_path, :name, :file_type, :file_size, :description, :document_type, :status)
  end
end
