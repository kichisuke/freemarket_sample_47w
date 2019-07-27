class User < ApplicationRecord
  has_many :bought_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item"
  has_many :likes
  has_many :comments
  has_one :profile, dependent: :destroy
  has_one :address, dependent: :destroy
  has_one :creditcard, dependent: :destroy

  validates :nickname, presence: true
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX, message: "指定した値で入力してください" }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.new(
        nickname:     auth.info.name,
        email:        auth.info.email,
        uid:          auth.uid,
        provider:     auth.provider
      )
    end
    user
  end
end
