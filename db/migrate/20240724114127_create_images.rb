class CreateImages < ActiveRecord::Migration[7.1]
  def change
    create_table :images do |t|
      t.references :attachable, polymorphic: true, null: false
      t.string :image_type
      t.timestamps
    end

    add_index :images, [:attachable_type, :attachable_id]
  end
end
