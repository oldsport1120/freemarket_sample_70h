class Products < ApplicationRecord
  # active_hashのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :pictures, dependent: :destroy
  # belongs_to user, foreign_key: 'user_id'
  belongs_to :category
end
