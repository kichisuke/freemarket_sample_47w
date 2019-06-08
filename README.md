# README

## users table

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, index: true|
|email|string|null: false, unique: true|
|password|string|null: false|
|avatar_image|text||

### Association
- has_many :bought_items, foreign_key: "buyer_id", class_name: "Item"
- has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
- has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item"
- has_many :likes
- has_many :comments


## profiles table

|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|profile_text|text||
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## addresses table

|Column|Type|Options|
|------|----|-------|
|postal_code|string|null: false|
|prefecture|string|null: false, index: true|
|city|string|null: false|
|street_address|string|null: false|
|building|string||
|phone_number|string|null: false, unique: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## creditcards table

|Column|Type|Options|
|------|----|-------|
|number|integer|null: false, unique: true|
|expiration_month|date|null: false|
|expiration_year|date|null: false|
|security_code|integer|null: false|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## sns_credentials table

|Column|Type|Options|
|------|----|-------|
|provider|string|unique: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## items table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|price|integer|null: false, index: true|
|text|text||
|condition|string|null: false|
|delivery_charge|integer|null: false|
|delivery_method|string|null: false|
|delivery_source_area|string|null: false|
|estimated_shipping_date|date|null: false|
|category_id|integer|null: false, foreign_key: true|
|brand_id|references||
|size|string||
|saler_id|references|null: false, foreign_key: true|
|buyer_id|references||
|sales_status|string|null: false|

### Association
- belongs_to :category
- belongs_to :brand
- has_many :images
- has_many :likes
- has_many :comments
- belongs_to :saler, class_name: "User"
- belongs_to :buyer, class_name: "User"


## item_images table

|Column|Type|Options|
|------|----|-------|
|url|string|null: false|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item

## likes table

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user 
- belongs_to :item


## comments table

|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item


## categories table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|parent_id|integer||

### Association
- has_many :items


## brands table

|Column|Type|Options|
|------|----|-------|
|name|string|index: true|

### Association
- has_many :items
