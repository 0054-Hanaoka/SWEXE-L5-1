class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user  # ← ここを修正
  validates :message, presence: true

  # いいねする
  def like(user)
    likes.create(user_id: user.id)
  end

  # いいね解除
  def unlike(user)
    likes.find_by(user_id: user.id)&.destroy
  end

  # いいね済みか確認
  def liked?(user)
    like_users.include?(user)
  end
end
