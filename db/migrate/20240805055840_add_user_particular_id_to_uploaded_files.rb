class AddUserParticularIdToUploadedFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :uploaded_files, :user_particular_id, :integer
  end
end
