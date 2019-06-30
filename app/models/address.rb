class Address < ApplicationRecord
  belongs_to :user

  validates :postal_code, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "指定した形式でご入力ください"}
  validates :prefecture_id, presence: true
  validates :city, presence: true
  validates :street_address, presence: true
  validates :phone_number, allow_nil: true, format: { with: /\A\d{10,11}\z/, message: "10桁または11桁の数字のみでご入力ください" }
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
