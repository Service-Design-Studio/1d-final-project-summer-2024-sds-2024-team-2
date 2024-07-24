class NgoUser < ApplicationRecord
  def self.find_by_id(id)
    NgoUser.find_by(id: id)
  end

  def self.search_by_name(name)
    NgoUser.where('name LIKE ?', "%#{name}%")
  end

  def self.all_ngo_users
    NgoUser.all
  end
end
