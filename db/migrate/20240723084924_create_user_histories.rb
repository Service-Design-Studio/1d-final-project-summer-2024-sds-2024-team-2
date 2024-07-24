class CreateUserHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :user_histories do |t|
      t.text :description
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
