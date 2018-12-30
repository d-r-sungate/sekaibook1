class AddColumnToBook < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :likes_count, :bigint, default: 0
  end
end
