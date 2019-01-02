class Book < ApplicationRecord
  belongs_to :user
  belongs_to :article
  has_many :like, dependent: :destroy
  has_many :like_users, through: :like, source: :user
  validates :comment,    length: { maximum: 10000 }
  
  def createlike(user)
      Like.create(user_id: user.id, book_id: self.id)
  end
  def dellike(user)
     Like.find_by(user_id: user.id, book_id: self.id).destroy
  end
  def like?(user)
    like_users.include?(user)
  end
end
