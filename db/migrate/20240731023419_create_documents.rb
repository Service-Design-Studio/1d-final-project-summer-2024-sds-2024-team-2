class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.string :title, null: false
      t.text :description
      t.references :attachable, polymorphic: true, null: false
      t.timestamps
    end
  end
end
