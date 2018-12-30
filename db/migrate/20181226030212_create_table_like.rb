class CreateTableLike < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.bigint :user_id,              null: false
      t.bigint :book_id,              null: false
      t.timestamps null: false
    end
    add_index :likes, :user_id,                unique: false
    add_index :likes, :book_id,                unique: false
  end
end
