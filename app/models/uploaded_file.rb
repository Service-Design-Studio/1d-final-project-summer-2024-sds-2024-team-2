class UploadedFile < ApplicationRecord
  belongs_to :user

  validates :file_name, :file_path, :file_type, :file_size, presence: true
end
