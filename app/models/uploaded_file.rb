# app/models/uploaded_file.rb
class UploadedFile < ApplicationRecord
  belongs_to :user_particular
  validates :name, :file_type, :file_size, :file_path, presence: true
end
