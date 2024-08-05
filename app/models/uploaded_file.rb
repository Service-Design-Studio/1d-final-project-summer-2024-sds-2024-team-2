class UploadedFile < ApplicationRecord
  belongs_to :user_particular
  has_one_attached :file_path

  validates :name, presence: true
  validates :file_type, presence: true
  validates :file_size, presence: true, numericality: { less_than_or_equal_to: 5.megabytes }

  def file_path_url
    Rails.application.routes.url_helpers.rails_blob_url(file_path, only_path: true) if file_path.attached?
  end
end
