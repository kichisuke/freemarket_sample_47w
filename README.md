# README

## users table

|Column|Type|Options|
|------|----|-------|
|nickname|integer|null: false, foreign_key: true|
|email|integer|null: false, foreign_key: true|
|password|||
|family_name|||
|family_name_kana|||
|first_name_kana|||
|phone_number|||
|profile_text|||
|avatar_image|||

### Association
- has_many :reviews
- has_many  :bought _items
- has_many :saling_items
- has_many  :sold_items


## addresses table

|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false, foreign_key: true|
|prefectures|integer|null: false, foreign_key: true|
|city|integer|null: false, foreign_key: true|
|street_address|integer|null: false, foreign_key: true|
|building|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user


## creditcards table

|Column|Type|Options|
|------|----|-------|
|number|integer|null: false, foreign_key: true|
|expiration_date|integer|null: false, foreign_key: true|
|security_code|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user


## accounts table

|Column|Type|Options|
|------|----|-------|
|facebook|integer|null: false, foreign_key: true|
|twitter|integer|null: false, foreign_key: true|
|google|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user


## items table

|Column|Type|Options|
|------|----|-------|
|name|integer|null: false, foreign_key: true|
|price|integer|null: false, foreign_key: true|
|text|integer|null: false, foreign_key: true|
|product_status|integer|null: false, foreign_key: true|
|delivery_charge|integer|null: false, foreign_key: true|
|delivery_method|integer|null: false, foreign_key: true|
|delivery_source_area|integer|null: false, foreign_key: true|
|estimated_shipping_date|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
|brand_id|integer|null: false, foreign_key: true|
|size_id|integer|null: false, foreign_key: true|
|saler_id|integer|null: false, foreign_key: true|
|buyer_id|integer|null: false, foreign_key: true|

### Association
- has_many :images
- has_many :likes
- belongs_to :user


## images table

|Column|Type|Options|
|------|----|-------|
|url|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :item

## likes table

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :item
- has_many :users


## comments table

|Column|Type|Options|
|------|----|-------|
|text|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|

### Association
- has_many :users
- belongs_to :item


## categories table

|Column|Type|Options|
|------|----|-------|
|name|integer|null: false, foreign_key: true|

### Association
- has_many :items


## brands table

|Column|Type|Options|
|------|----|-------|
|name|integer|null: false, foreign_key: true|

### Association
- has_many :items


## sizes table

|Column|Type|Options|
|------|----|-------|
|name|integer|null: false, foreign_key: true|

### Association
- has_many :items

## transactions table

|Column|Type|Options|
|------|----|-------|
|message|integer|null: false, foreign_key: true|
|saler_id|integer|null: false, foreign_key: true|
|buyer_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :item


## reviews table

|Column|Type|Options|
|------|----|-------|
|rate|integer|null: false, foreign_key: true|
|review|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
