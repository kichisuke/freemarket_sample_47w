class Item < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  has_many :item_images
  has_many :likes
  has_many :comments
  belongs_to :saler, class_name: "User"
  belongs_to :buyer, class_name: "User"
end
