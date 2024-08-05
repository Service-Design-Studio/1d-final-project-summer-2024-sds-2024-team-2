class UploadedFilesController < ApplicationController
  before_action :set_user_particular

  def create
    @uploaded_file = @user_particular.uploaded_files.build(uploaded_file_params)
    @uploaded_file.status = 'Unverified' if @uploaded_file.status.blank?

    if @uploaded_file.save
      render json: { success: true, file: @uploaded_file.as_json.merge({ file_url: @uploaded_file.file_url }) }, status: :created
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
