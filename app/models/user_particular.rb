# app/models/user_particular.rb
class UserParticular < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_picture
  has_many :documents, dependent: :destroy
  has_many :uploaded_files, dependent: :destroy # Ensure the association is established

  before_create :assign_unique_id
  before_create :generate_2fa_secret

  def self.create_user_particular(attributes)
    UserParticular.create(attributes)
  end

  def self.find_by_id(id)
    UserParticular.find_by(id: id)
  end

  def self.find_by_unique_id(unique_id)
    UserParticular.find_by(unique_id: unique_id)
  end

  def self.find_by_unique_id_and_two_fa_passcode(unique_id, two_fa_passcode)
    UserParticular.find_by(unique_id: unique_id, two_fa_passcode: two_fa_passcode)
  end

  def self.update_user_particular(id, attributes)
    user_particular = find_by(id: id)
    return nil unless user_particular

    user_particular.update(attributes)
    user_particular
  end

  def self.reset_verification(id)
    user_particular = UserParticular.find_by(id: id)
    user_particular.update(status: 'pending', verifier_ngo: nil)
  end

  private

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
