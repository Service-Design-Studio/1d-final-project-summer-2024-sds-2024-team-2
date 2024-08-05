class UploadedFilesController < ApplicationController
  before_action :set_user_particular

  def index
    @uploaded_files = @user_particular.uploaded_files
    render json: @uploaded_files.map { |file| file.attributes.merge(upload_date: file.created_at.strftime('%d/%m/%y')) }
  end

  def create
    @uploaded_file = @user_particular.uploaded_files.new(uploaded_file_params)
    @uploaded_file.upload_date = Time.now.strftime('%d/%m/%y')

    if @uploaded_file.save
      render json: { success: true, file: @uploaded_file.attributes.merge(upload_date: @uploaded_file.created_at.strftime('%d/%m/%y')) }
    else
      Rails.logger.error("Failed to upload file: #{@uploaded_file.errors.full_messages.join(', ')}")
      render json: { success: false, errors: @uploaded_file.errors.full_messages }
    end
  end

  def destroy
    @uploaded_file = @user_particular.uploaded_files.find(params[:id])
    @uploaded_file.destroy
    head :no_content
  end

  private

  def set_user_particular
    @user_particular = UserParticular.find(params[:user_particular_id])
  end

  def uploaded_file_params
    params.require(:uploaded_file).permit(:file_path, :name, :file_type, :file_size)
  end
end
