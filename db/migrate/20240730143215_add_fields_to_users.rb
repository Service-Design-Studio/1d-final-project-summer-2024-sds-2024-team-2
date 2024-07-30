class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :registered, :boolean unless column_exists?(:users, :registered)
    add_column :users, :needs_document_upload, :boolean unless column_exists?(:users, :needs_document_upload)
  end
end
