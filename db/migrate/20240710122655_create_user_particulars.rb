class CreateUserParticulars < ActiveRecord::Migration[7.1]
  def change
    create_table :user_particulars do |t|
      t.string :full_name
      t.string :phone_number_country_code
      t.string :phone_number
      t.string :full_phone_number
      t.string :secondary_phone_number_country_code
      t.string :secondary_phone_number
      t.string :full_secondary_phone_number
      t.string :country_of_origin
      t.string :ethnicity
      t.string :religion
      t.string :gender
      t.date :date_of_birth
      t.date :date_of_arrival
      t.string :photo_url
      t.string :birth_certificate_url
      t.string :passport_url
      t.string :verifier_ngo
      t.integer :unique_id, limit: 4
      t.integer :two_fa_passcode, limit: 3
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
