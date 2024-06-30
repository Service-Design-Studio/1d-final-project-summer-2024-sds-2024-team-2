class AddFieldsToUserParticulars < ActiveRecord::Migration[7.1]
  def change
    add_column :user_particulars, :secondary_phone_number, :string unless column_exists?(:user_particulars, :secondary_phone_number)
    add_column :user_particulars, :date_of_arrival_in_malaysia, :date unless column_exists?(:user_particulars, :date_of_arrival_in_malaysia)
  end
end
