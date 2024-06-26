class UserParticular < ActiveRecord::Base
  belongs_to :user

  def self.create_user_particular(attributes)
    UserParticular.create(attributes)
  end

  def self.find_by_id(id)
    UserParticular.find_by(id:)
  end
end
