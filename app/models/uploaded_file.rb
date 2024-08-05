# app/models/uploaded_file.rb
class UploadedFile < ApplicationRecord
  belongs_to :user
  mount_uploader :file_path, DocumentUploader
end
