class AddUploadDateToUploadedFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :uploaded_files, :upload_date, :datetime
  end
end
