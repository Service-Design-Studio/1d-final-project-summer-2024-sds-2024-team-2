class AddPhotoToBulletins < ActiveRecord::Migration[7.1]
  def change
    add_column :bulletins, :photo, :string
  end
end
