class UpdateUploadedFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :uploaded_files, :needs_document_upload, :boolean
    rename_column :uploaded_files, :file_name, :name
  end
end
