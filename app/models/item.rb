class Item < ApplicationRecord
  belongs_to :category
  belongs_to :brand, optional: true
  has_many :item_images
  accepts_nested_attributes_for :item_images
  has_many :likes
  has_many :comments
  belongs_to :saler, class_name: "User", foreign_key: 'saler_id'
  belongs_to :buyer, class_name: "User", foreign_key: 'buyer_id', optional: true
  with_options presence: true do
    validates :name, :price, :text, :category_id, :size, :condition, :delivery_charge, :delivery_method, :prefecture_id, :estimated_shipping_date, :sales_status
  end
  validates :price, numericality: {greater_than_or_equal_to: 300,less_than_or_equal_to: 9_999_999}

  enum condition: { brand_new: 0, near_unused: 1, low_damage: 2, mid_damage: 3, high_damage: 4, bad: 5 }
  enum delivery_charge: { postage_included: 0, cash_on_delivery: 1 }
  enum delivery_method: { mercari: 0, yu_mail: 1, letter_pack: 2, normal_post: 3, kuroneko: 4, yu_pack: 5, click_post: 6, yu_packet: 7 }
  enum estimated_shipping_date: { shipping1: 0, shipping2: 1, shipping3: 2 }
  enum size: { xxs: 0, xs: 1, s: 2, m: 3, l: 4, xl: 5, xl2: 6, xl3: 7, xl4: 8, xl5: 9, free_size: 10 }
  enum sales_status: { exhibition: 0, stop: 1, trading: 2, sold: 3 }

  scope :topItem, -> (category) { where("category_id = #{category}").order(created_at: :desc).limit(4) }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
