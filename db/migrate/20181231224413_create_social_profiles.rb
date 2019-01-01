class CreateSocialProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :social_profiles do |t|
      t.references :user, foreign_key: true
      t.string :provider, limit: 191
      t.string :uid, limit: 191
      t.string :username
      t.string :email
      t.string :image
      t.string :oauth_token
      t.string :oauth_token_secret
      t.timestamps
    end
    add_index :social_profiles, [:provider, :uid], unique: true
  end
end
