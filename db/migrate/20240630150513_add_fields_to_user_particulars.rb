class AddFieldsToUserParticulars < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:user_particulars, :secondary_phone_number)
      add_column :user_particulars, :secondary_phone_number, :string
    end

    unless column_exists?(:user_particulars, :date_of_arrival_in_malaysia)
      add_column :user_particulars, :date_of_arrival_in_malaysia, :date
    end
  end
end
