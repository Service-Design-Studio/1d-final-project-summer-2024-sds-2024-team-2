class UploadedFile < ApplicationRecord
  belongs_to :user_particular

  validates :name, :file_path, :file_type, :file_size, presence: true
end
