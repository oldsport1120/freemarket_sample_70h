class Product < ApplicationRecord
  # active_hashのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  has_many :pictures, dependent: :destroy
end
