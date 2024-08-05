# app/controllers/uploaded_files_controller.rb
class UploadedFilesController < ApplicationController
  def create
    @user_particular = UserParticular.find(params[:user_particular_id])
    @uploaded_file = @user_particular.uploaded_files.new(uploaded_file_params)

    if @uploaded_file.save
      @uploaded_file.file_path.attach(params[:uploaded_file][:file_path])
      render json: @uploaded_file.as_json.merge({ file_path_url: @uploaded_file.file_path_url }), status: :created
    else
      render json: @uploaded_file.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @uploaded_file = UploadedFile.find(params[:id])
    @uploaded_file.destroy
    head :no_content
  end

  private

  def uploaded_file_params
    params.require(:uploaded_file).permit(:file_path, :name, :file_type, :file_size)
  end
end
