class CreateUploadedFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :uploaded_files do |t|
      t.string :name
      t.string :file_type
      t.integer :file_size
      t.string :file_path
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
