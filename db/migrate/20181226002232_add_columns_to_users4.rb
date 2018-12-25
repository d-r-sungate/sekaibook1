class AddColumnsToUsers4 < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :auto_post_facebook, :boolean, null: true, default: false
    add_column :users, :auto_post_twitter, :boolean, null: true, default: false
  end
end
