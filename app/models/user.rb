class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :validatable, password_length: 7..128
         #password_length１行追加中実験成功

  # 正規表現 半角英数のみ
  SMALL_LETTERS_REGEX = /\A[a-z0-9]+\z/i
  # validates :password, format: { with: SMALL_LETTERS_REGEX }
  # validates :zip_code, format: { with: SMALL_LETTERS_REGEX }
  
  # validatesをかける nonaka
  # null規制
  validates :nickname, :email,                                  presence: true
  validates :family_name, :first_name,                          presence: true
  validates :family_name_kana, :first_name_kana,                presence: true
  validates :date_of_birth,                                     presence: true

  # validatesをかける nonaka
  # shipments用のバリデーション
  validates :ship_family_name, :ship_first_name,                 presence: true
  validates :ship_family_name_kana, :ship_first_name_kana,       presence: true
  # validates :zip_code, format: { with: SMALL_LETTERS_REGEX },  presence: true
  validates :zip_code,                                           presence: true
  validates :prefecture, :city, :street,                         presence: true
  
  # deviseはconfig/initializer/devise.rb にvalidation初期設定あり nonaka

  # その他validation nonaka
  validates :email,                                            uniqueness: true
  # .com .jp などがないとメールを入力できないように これは効いているように思える
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }


  # 文字数 nonaka
  # validates :password,            length: { minimum: 7 } この１行を入れると登録できなくなるdevice初期設定とかんしょうか？
  # password文字数はconfig/devise.rbでのバリデーションが効いているエラーメッセージも出る
  # validates :zip_code,            length: { is: 7 }
  # validates :zip_code, format: { with: /\A[a-zA-Z0-9]+\z/, message: "半角英数字のみが使えます" } 
  # ↑ 現在これが効いていない データには0になって入るので、少しは効いているがエラ〜扱いにならない

  

  # 以下検討・実験中nonaka
  # validates :password,      presence: { message: 'パスワードは７文字以上で入力してください' }  
  # validates :email, format: { with: [a-zA-Z0-9].+@.+[a-zA-Z0-9].+..+[a-zA-Z0-9] }
  

end

