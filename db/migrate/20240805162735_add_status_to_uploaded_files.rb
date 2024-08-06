class AddStatusToUploadedFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :uploaded_files, :status, :string
  end
end
