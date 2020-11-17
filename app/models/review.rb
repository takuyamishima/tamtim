class Review < ApplicationRecord
    mount_uploaders :images, ImageUploader

    belongs_to :user, optional: true
    has_many :reviewtags, dependent: :destroy
    has_many :reviewtag_hashtags, through: :reviewtags, source: :hashtag
    accepts_nested_attributes_for :reviewtags, allow_destroy: true
    has_many :favorites, dependent: :destroy
    has_many :favorite_users, through: :favorites, source: :user
    has_many :likes, dependent: :destroy
    has_many :like_users, through: :likes, source: :user
    has_many :comments, dependent: :destroy
    has_many :notifications, dependent: :destroy

    acts_as_taggable_on :labels # post.label_list が追加される
    acts_as_taggable            # acts_as_taggable_on :tags のエイリアス
    acts_as_ordered_taggable_on :skills, :interests

    validates :title, presence: true
    validates :content, presence: true, on: :save
    validates :category_name, presence: true, on: :save

  # 与えられたユーザーがフォローしているユーザー達のマイクロポストを返す。
  def self.from_users_following_by(user)
    following_user_ids = "SELECT following_id FROM relationships
                         WHERE following_id = :user_id"
    where("user_id IN (#{following_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

  def iine(user)
    likes.create(user_id: user.id)
  end

  # マイクロポストのいいねを解除する（ネーミングセンスに対するクレームは受け付けません）
  def uniine(user)
    likes.find_by(user_id: user.id).destroy
  end

  # 現在のユーザーがいいねしてたらtrueを返す
  def iine?(user)
    like_users.include?(user)
  end

is_impressionable

end
