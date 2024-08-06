class CreateNgoServices < ActiveRecord::Migration[6.1]
  def change
    create_table :ngo_services do |t|
      t.integer :ngo_user_id, null: false, foreign_key: true
      t.text :services

      t.timestamps
    end
  end
end