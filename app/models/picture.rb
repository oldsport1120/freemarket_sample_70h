class Picture < ApplicationRecord
  mount_uploader :picture, ImageUploader
  belongs_to :product, optional: true, inverse_of: :pictures
end
