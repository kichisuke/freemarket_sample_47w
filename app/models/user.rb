class User < ApplicationRecord
  has_many :bought_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item"
  has_many :likes
  has_many :comments
  has_one :address
  has_one :profile
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable     
end
