class NgoUser < ApplicationRecord
  def self.find_by_id(id)
    NgoUser.find_by(id: id)
  end
end
