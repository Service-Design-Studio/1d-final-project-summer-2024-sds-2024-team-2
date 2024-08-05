# app/controllers/uploaded_files_controller.rb
class UploadedFilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @uploaded_files = current_user.uploaded_files
  end

  def create
    @uploaded_file = current_user.uploaded_files.build(uploaded_file_params)
    if @uploaded_file.save
      render json: @uploaded_file, status: :created
    else
      render json: @uploaded_file.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @uploaded_file = current_user.uploaded_files.find(params[:id])
    @uploaded_file.destroy
    head :no_content
  end

  private

  def uploaded_file_params
    params.require(:uploaded_file).permit(:name, :file_type, :file_size, :file_path)
  end
end
