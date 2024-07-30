class AddBulletinIdToSavedPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :saved_posts, :bulletin_id, :integer
  end
end
