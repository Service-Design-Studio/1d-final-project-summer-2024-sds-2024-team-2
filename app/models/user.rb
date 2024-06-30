class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_particular, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :phone_number, presence: true
end
