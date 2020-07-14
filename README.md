# データベース設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false,unique: true|
|password|string|null: false|
|password_confirmation|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|stirng|null: false|
|first_name_kana|string|null: false|
|date_of_birth|integer|null: false|
### Association
- has_many: products, dependent: :destroy
- has_many: likes, dependent: :destroy
- has_many: comments, dependent: :destroy
- has_one: shipment, dependent: :destroy
- has_one: payment, dependent: :destroy


## shipmentsテーブル
|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|zip_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|street|integer|null: false|
|room_number|integer||
|tel|integer||
|user_id|integer|foreign_key: true|
### Association
- belongs_to: user


## paymentsテーブル
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false|
|exp_year|integer|null: false|
|exp_month|integer|null: false|
|cvc_number|integer|null: false|
|card_owner|string||
|user_id|integer|foreign_key: true|
### Association
- belongs_to: user


## productsテーブル
|Column|Type|Options|
|------|----|-------|
|product_name|string|null: false|
|description|text|null: false|
|price|integer|null: false|
|brand|string||
|product_conditon|string|null: false|
|shipment_fee|string|null: false|
|prefecture|integer|null: false|
|shipping_period|string|null: false|
|user_id|integer|foreign_key: true|
|category_id|integer|foreign_key: true|
|buyer_id|integer||
|sale_status|integer|null: false, default: 0|

### Association
- has_many: pictures, dependent: :destroy
- belongs_to: category
- belongs_to: user


## picturesテーブル
|Column|Type|Options|
|------|----|-------|
|picture|string|null:false|
|product_id|integer|foreign_key: true|
### Association
- belongs_to: product


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||
### Association
- has_many: products
- has_ancestry


## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|foreign_key: true|
|product_id|integer|foreign_key: true|
### Association
- belongs_to: user
- belongs_to: product


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|body|text|null: false|
|user_id|integer|foreign_key: true|
|product_id|integer|foreign_key: true|
### Association
- belongs_to: user
- belongs_to: product