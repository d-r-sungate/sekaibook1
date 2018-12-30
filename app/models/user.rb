class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  validates :oganization,    length: { maximum: 200 }
  validates :title,    length: { maximum: 200 }
  validates :introduction,    length: { maximum: 2000 }
  validates :country,    length: { maximum: 100 }
    
  has_many :like, dependent: :destroy

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    if auth.info.email then
      email = auth.info.email
    else
      email = User.dummy_email(auth)
    end
    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    email,
        password: Devise.friendly_token[0, 20],
        image: auth.info.image,
        username: name
        )
    end

    user
   end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
