class CreateSavedPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :saved_posts do |t|
      t.string :title
      t.datetime :date
      t.string :location
      t.text :description
      t.string :ngo_name
      t.boolean :saved
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
