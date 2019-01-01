class SocialProfile < ApplicationRecord
  belongs_to :user
  store      :others

  validates_uniqueness_of :uid, scope: :provider

  def self.find_for_oauth(user_id, auth)
    profile = SocialProfile.where(user_id: user_id, uid: auth.uid, provider: auth.provider).first
    if auth.info.email then
      email = auth.info.email
    else
      email = User.dummy_email(auth)
    end
    unless profile
      profile = SocialProfile.create(
        user_id:      user_id,
        uid:      auth.uid,
        provider: auth.provider,
        email:    email,
        image: auth.info.image,
        username: name
        )
    end
    profile
  end
end
