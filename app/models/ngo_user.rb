class NgoUser < ApplicationRecord
  has_many :messages, class_name: 'Message'

end
