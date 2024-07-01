class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string, null: false, default: "" unless column_exists?(:users, :username)
    add_column :users, :phone_number, :string, null: false, default: "" unless column_exists?(:users, :phone_number)
  end
end
