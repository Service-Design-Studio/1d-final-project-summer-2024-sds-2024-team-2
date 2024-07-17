class User < ApplicationRecord
  has_one :user_particular
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def self.find_by_email_or_phone(email_or_phone)
    where('email = :value OR phone_number = :value', value: email_or_phone).first
  end
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, format: { with: /\A[0-9]+\z/, message: :invalid }, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  # Comment out to attempt fix for NoMethodError (super: no superclass method 'password' for #<User in deployment
  # def password
  #   Rails.env.development? || Rails.env.test? ? 'adminpassword' : super
  # end

  # def password_confirmation
  #   Rails.env.development? || Rails.env.test? ? 'adminpassword' : super
  # end
end
