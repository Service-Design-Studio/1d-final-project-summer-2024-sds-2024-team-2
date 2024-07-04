class UserParticular < ApplicationRecord
  belongs_to :user

  validates :full_name, presence: true
  validates :phone_number, presence: true
  validates :country_of_origin, presence: true
  validates :ethnicity, presence: true
  validates :religion, presence: true
  validates :gender, presence: true
  validates :date_of_birth, presence: true
  validates :date_of_arrival_in_malaysia, presence: true

  def self.create_user_particular(attributes)
    create(attributes)
  end

  def self.find_by_id(id)
    find_by(id: id)
  end


  def self.update_user_particular(id, attributes)
    user_particular= UserParticular.find_by(id: id)
    user_particular.update(attributes)
    user_particular
  end

end