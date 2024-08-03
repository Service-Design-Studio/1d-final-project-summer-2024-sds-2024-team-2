class NgoService < ApplicationRecord
  belongs_to :ngo_user, class_name: 'NgoUser', foreign_key: 'ngo_user_id'
end
