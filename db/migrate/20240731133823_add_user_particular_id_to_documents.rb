class AddUserParticularIdToDocuments < ActiveRecord::Migration[7.1]
  def change
    add_column :documents, :user_particular_id, :integer
  end
end
