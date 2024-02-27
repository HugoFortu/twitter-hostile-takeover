class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  def self.likes_ranking
    self.joins(:tweets)
        .group("users.id")
        .select("users.*, sum(tweets.grade) as total")
        .order("total desc")
  end
end
