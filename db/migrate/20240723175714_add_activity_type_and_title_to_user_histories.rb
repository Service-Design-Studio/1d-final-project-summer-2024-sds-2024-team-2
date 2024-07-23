class AddActivityTypeAndTitleToUserHistories < ActiveRecord::Migration[7.1]
  def change
    add_column :user_histories, :activity_type, :string
    add_column :user_histories, :activity_title, :string
  end
end
