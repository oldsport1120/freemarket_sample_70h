class Product < ApplicationRecord
  # active_hashのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures
  validates :products_name, presence: true, length: { maximum: 40 }
  validates :descreption, presence: true, length: { maximum: 1000 }
  validates :price, :product_condition, :shipment_fee, :shipping_place, presence: true
end
