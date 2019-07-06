class Category < ApplicationRecord
  has_many :items
  belongs_to :parent, class_name: :Category
  has_many :children, class_name: :Category, foreign_key: :parent_id
end
