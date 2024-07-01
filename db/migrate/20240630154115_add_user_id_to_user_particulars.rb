class AddUserIdToUserParticulars < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:user_particulars, :user_id)
      add_reference :user_particulars, :user, null: false, foreign_key: true
    end
  end
end
