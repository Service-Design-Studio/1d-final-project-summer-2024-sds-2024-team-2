class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.references :attachable, polymorphic: true, null: false
      t.string :document_type
      t.timestamps
    end

    add_index :documents, [:attachable_type, :attachable_id]
  end
end
