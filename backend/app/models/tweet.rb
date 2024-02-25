class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image

  def to_complete_hash
    user_pseudo = self.user.pseudo
    comments = self.comments
    likes = self.likes
    self.attributes.merge({ pseudo: user_pseudo, comments: comments, likes: likes })
  end
end
