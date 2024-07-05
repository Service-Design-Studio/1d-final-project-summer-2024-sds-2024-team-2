class AddAddressToUserParticulars < ActiveRecord::Migration[7.1]
  def change
    add_column :user_particulars, :full_phone_number, :string
  end
end
