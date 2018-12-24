class AddColumnsToUsers3 < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image, :string
    add_column :users, :introduction, :string
    add_column :users, :oganization, :string
    add_column :users, :title, :string
    add_column :users, :country, :string
  end
end
