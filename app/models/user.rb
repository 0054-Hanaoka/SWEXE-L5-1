class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :tweet

  has_one :profile, dependent: :destroy

  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :tweets

  validates :uid, presence: true, uniqueness: true
  validates :password, presence: true

  
  has_secure_password
end
