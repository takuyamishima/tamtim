class User < ApplicationRecord
  mount_uploader :avator, IconUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :reviews
  has_many :favorites, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

         def self.find_for_facebook_oauth(auth)
          user = User.where(uid: auth.uid, provider: auth.provider).first

          unless user
            user = User.create(
              uid:      auth.uid,
              provider: auth.provider,
              email:    auth.info.email,
              name:     auth.info.name,
              icon:     auth.info.image,
              password: Devise.friendly_token[0, 20]
            )
          end

          return user
        end
end
