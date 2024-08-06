# app/models/user_particular.rb
class UserParticular < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_picture
  has_many :documents, dependent: :destroy
  has_many :uploaded_files, dependent: :destroy # Ensure the association is established

  before_create :assign_unique_id
  before_create :generate_2fa_secret

  # Presence Validations
  validates :full_name, presence: true
  validates :phone_number, presence: true
  validates :country_of_origin, presence: true
  validates :ethnicity, presence: true
  validates :religion, presence: true
  validates :gender, presence: true
  validates :date_of_birth, presence: true
  validates :date_of_arrival, presence: true

  def assign_unique_id
    loop do
      unique_id = rand(1_000_000..9_999_999)
      unless UserParticular.exists?(unique_id: unique_id)
        self.unique_id = unique_id
        break
      end
    end
  end

  def generate_2fa_secret
    self.two_fa_passcode = rand(100_000..999_999)
  end
end
