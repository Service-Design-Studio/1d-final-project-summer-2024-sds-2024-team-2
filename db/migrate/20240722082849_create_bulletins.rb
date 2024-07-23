class CreateBulletins < ActiveRecord::Migration[7.1]
  def change
    create_table :bulletins do |t|
      t.string :title
      t.datetime :date
      t.string :location
      t.text :description
      t.string :ngo_name
      t.boolean :saved

      t.timestamps
    end
  end
end
