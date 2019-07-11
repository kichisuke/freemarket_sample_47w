class Address < ApplicationRecord
  belongs_to :user

  validates :postal_code, presence: true, format: { with: /\A\d{7}\Z/ }
  validates :prefecture_id, presence: true
  validates :city, presence: true
  validates :street_address, presence: true
end
