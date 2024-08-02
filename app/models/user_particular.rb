class UserParticular < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_picture
  has_many :documents, dependent: :destroy # Add this line to establish the association

  before_create :assign_unique_id
  before_create :generate_2fa_secret

  def assign_unique_id
    loop do
      unique_id = rand(1_000_000..9_999_999)
      unless UserParticular.exists?(unique_id: unique_id)
        self.unique_id = unique_id #Assign unique id to user particular
        break
      end
    end
  end

  def generate_2fa_secret
    self.two_fa_passcode = rand(100_000..999_999)
  end

end
