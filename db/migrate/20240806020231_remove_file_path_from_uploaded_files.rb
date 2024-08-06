class RemoveFilePathFromUploadedFiles < ActiveRecord::Migration[7.1]
  def change
    remove_column :uploaded_files, :file_path, :string
  end
end
