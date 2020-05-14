class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # validatesをかける nonaka
  # null規制
  validates :nickname, :email,                         presence: true
  validates :family_name, :first_name,                 presence: true
  validates :family_name_kana, :first_name_kana,       presence: true
  validates :date_of_birth,                            presence: true

end
