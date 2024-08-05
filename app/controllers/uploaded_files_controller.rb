class UploadedFilesController < ApplicationController
  before_action :set_user_particular, only: [:index, :create, :destroy, :update]
  before_action :set_uploaded_file, only: [:destroy, :update]

  def index
    @uploaded_files = @user_particular.uploaded_files
    render json: @uploaded_files.map { |file|
      file.as_json.merge({
        file_size: file.file_path.byte_size,
        upload_date: file.created_at.strftime('%Y-%m-%d'),
        description: file.description,
        document_type: file.document_type,
        status: file.status,
        file_url: rails_blob_url(file.file_path, disposition: "attachment")
      })
    }
  end

  def create
    Rails.logger.debug "Uploaded file params: #{uploaded_file_params.inspect}"
    @uploaded_file = @user_particular.uploaded_files.new(uploaded_file_params.except(:status))
    @uploaded_file.status = 'Unverified' # Set status to Unverified after initialization

    if @uploaded_file.save
      render json: { success: true, file: @uploaded_file }, status: :created
    else
      render json: { success: false, errors: @uploaded_file.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @uploaded_file.update(uploaded_file_params)
      render json: { success: true, file: @uploaded_file }, status: :ok
    else
      render json: { success: false, errors: @uploaded_file.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @uploaded_file.destroy
    head :no_content
  end

  private

  def set_user_particular
    @user_particular = UserParticular.find(params[:user_particular_id])
  end

  def set_uploaded_file
    @uploaded_file = @user_particular.uploaded_files.find(params[:id])
  end

  def uploaded_file_params
    params.require(:uploaded_file).permit(:file_path, :name, :file_type, :file_size, :description, :document_type)
  end
end
