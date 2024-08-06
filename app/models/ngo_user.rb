class NgoUser < ApplicationRecord
  has_many :messages, class_name: 'Message'
  has_many :ngo_services, dependent: :destroy

end