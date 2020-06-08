class Product < ApplicationRecord
  # active_hashのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  
  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures

  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'

  validates :products_name, presence: true, length: { maximum: 40 }
  validates :descreption, presence: true, length: { maximum: 1000 }
  validates :price, :product_condition, :shipment_fee, :shipping_place, presence: true
end
