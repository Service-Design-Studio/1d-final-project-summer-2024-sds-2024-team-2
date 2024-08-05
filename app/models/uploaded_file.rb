class UploadedFile < ApplicationRecord
  belongs_to :user_particular
  has_one_attached :file_path

  validates :name, :file_type, :file_size, presence: true

  def file_url
    Rails.application.routes.url_helpers.rails_blob_path(file_path, only_path: true) if file_path.attached?
  end
end
