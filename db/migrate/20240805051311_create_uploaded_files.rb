class CreateUploadedFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :uploaded_files do |t|
      t.references :user, null: false, foreign_key: true
      t.string :file_name, null: false
      t.string :file_path, null: false
      t.string :file_type, null: false
      t.integer :file_size, null: false
      t.timestamps
    end
  end
end
