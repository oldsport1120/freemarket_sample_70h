class Card < ApplicationRecord
  belongs_to :user
  validates :customer_token, presence: true


end
