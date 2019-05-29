# README

## users table

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|integer|null: false, unique: true|
|password|string|null: false, unique: true|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|phone_number|string|null: false, unique: true|
|profile_text|text||
|avatar_image|text||

### Association
- has_many :reviews
- has_many :bought_items
- has_many :saling_items
- has_many :sold_items


## addresses table

|Column|Type|Options|
|------|----|-------|
|postal_code|string|null: false|
|prefectures|string|null: false|
|city|string|null: false|
|street_address|string|null: false|
|building|string||
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## creditcards table

|Column|Type|Options|
|------|----|-------|
|number|integer|null: false, unique: true|
|expiration_date|date|null: false|
|security_code|integer|null: false|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## accounts table

|Column|Type|Options|
|------|----|-------|
|facebook|string|unique: true|
|twitter|string|unique: true|
|google|string|unique: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## items table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|text|text||
|product_status|string|null: false|
|delivery_charge|integer|null: false|
|delivery_method|string|null: false|
|delivery_source_area|string|null: false|
|estimated_shipping_date|date|null: false|
|category_id|integer|null: false, foreign_key: true|
|brand_id|references||
|size_id|references||
|saler_id|references|null: false, foreign_key: true|
|buyer_id|references||

### Association
- has_many :images
- has_many :likes
- belongs_to :user


## images table

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
- belongs_to :item
- has_many :users


## comments table

|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- has_many :users
- belongs_to :item


## categories table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :items


## brands table

|Column|Type|Options|
|------|----|-------|
|name|string||

### Association
- has_many :items


## sizes table

|Column|Type|Options|
|------|----|-------|
|name|string||

### Association
- has_many :items

## transactions table

|Column|Type|Options|
|------|----|-------|
|message|text|null: false|
|saler_id|references|null: false, foreign_key: true|
|buyer_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item


## reviews table

|Column|Type|Options|
|------|----|-------|
|rate|integer|null: false|
|review|text||
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
