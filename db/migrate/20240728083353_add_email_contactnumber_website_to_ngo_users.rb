class AddEmailContactnumberWebsiteToNgoUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :ngo_users, :email, :string
    add_column :ngo_users, :contact_number, :string
    add_column :ngo_users, :website, :string
  end
end
