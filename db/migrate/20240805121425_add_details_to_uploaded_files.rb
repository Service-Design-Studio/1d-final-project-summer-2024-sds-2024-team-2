class AddDetailsToUploadedFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :uploaded_files, :description, :text
    add_column :uploaded_files, :document_type, :string
  end
end
