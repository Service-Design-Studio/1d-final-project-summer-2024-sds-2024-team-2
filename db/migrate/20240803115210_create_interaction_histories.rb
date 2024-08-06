class CreateInteractionHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :interaction_histories do |t|
      t.string :activity_title
      t.text :description
      t.string :activity_type
      t.references :ngo_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end