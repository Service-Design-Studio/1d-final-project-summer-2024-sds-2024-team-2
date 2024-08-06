class User < ApplicationRecord
  has_one :user_particular, dependent: :destroy
  has_one :user_history, dependent: :destroy
  has_many :messages, class_name: 'Message', dependent: :destroy
  has_many :saved_posts, dependent: :destroy
  has_many :documents, dependent: :destroy

  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :phone_number, format: { with: /\A[0-9]+\z/, message: :invalid }, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :email, presence: true, uniqueness: true

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login).downcase
    where(conditions).where(['lower(username) = :value OR lower(email) = :value OR phone_number = :value',
                             { value: login }]).first
  end

  def send_message(user, ngo, message)
    @new_message = Message.new(user_id: user, ngo_users_id: ngo, message: message)
    @new_message.save
  end
end
