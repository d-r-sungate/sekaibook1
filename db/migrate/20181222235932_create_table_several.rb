class CreateTableSeveral < ActiveRecord::Migration[5.2]
  def change
    create_table :areas do |t|
      t.string :description,              null: true, default: ""
      t.timestamps null: false
    end

    create_table :articles do |t|
      t.string :url,              null: false, default: ""
      t.string :title,              null: true, default: ""
      t.string :domain,              null: true, default: ""
      t.string :description,              null: true, default: ""
      t.string :name,              null: true, default: ""
      t.string :ogpdescription,              null: true, default: ""
      t.string :ogpimg,              null: true, default: ""
      t.string :favicon,              null: true, default: ""
      t.bigint :category_id,              null: false
      t.bigint :area_id,              null: false
      t.datetime :date
      t.bigint :user_id,              null: false
      t.timestamps null: false
    end
    add_index :articles, :category_id,                unique: false
    add_index :articles, :area_id,                unique: false

    create_table :categories do |t|
      t.string :description,              null: true, default: ""
      t.timestamps null: false
    end

    create_table :likes do |t|
      t.bigint :user_id,              null: false
      t.text :comment, :limit => 4294967295, null: true, default: ""
      t.timestamps null: false
    end
    add_index :likes, :user_id,                unique: false

    create_table :books do |t|
      t.bigint :user_id,              null: false
      t.bigint :article_id,              null: false
      t.text :comment, :limit => 4294967295, null: true, default: ""
      t.timestamps null: false
    end
    add_index :books, [:user_id,:article_id] ,              unique: false
  end
end
