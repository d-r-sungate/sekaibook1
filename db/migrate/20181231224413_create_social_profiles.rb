class CreateSocialProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :social_profiles do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :username
      t.string :email
      t.string :image
      t.timestamps
    end
    add_index :social_profiles, [:provider, :uid], unique: true
  end
end
