class Message < ApplicationRecord
  # Each message belongs to a user and an ngo
  belongs_to :user
  belongs_to :ngo_user, optional: true

  validates :message, presence: true

  def self.all_received_messages(user_id)
      Message.where(ngo_users_id: user_id).joins(user: :user_particular)
           .select('messages.message as message, messages.created_at as createdAt, users.email as email, user_particulars.*')
           .order('messages.created_at DESC')
  end
end