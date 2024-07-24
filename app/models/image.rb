class Image < ApplicationRecord
  belongs_to :attachable, polymorphic: true
  has_one_attached :image_file

  # Optional: add validations or additional methods
  validates :image_type, presence: true # if you are using the image_type column
end
