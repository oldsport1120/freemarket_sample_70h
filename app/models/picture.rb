class Picture < ApplicationRecord
  mount_uploader :picture, ImageUploader
  belongs_to :product
end
