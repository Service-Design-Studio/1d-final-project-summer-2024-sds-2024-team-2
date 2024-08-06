class UploadedFile < ApplicationRecord
  belongs_to :user_particular
  belongs_to :user
  has_one_attached :file_path

  validates :name, :file_type, :file_size, presence: true
  validates :file_path, presence: true

  def file_url
    Rails.application.routes.url_helpers.rails_blob_path(file_path, only_path: true) if file_path.attached?
  end

  scope :verified, -> { where(status: 'Verified') }
end
