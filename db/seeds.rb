# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 初期データ・テストデータ投入 nonaka
# こちらのデータはターミナルで$rails db:seed で流し込めます nonaka
User.create!(
  nickname: "Tech",
  email: "admin@2222",
  password: "admin12345",
  encrypted_password: "admin12345",
  family_name: "手区",
  first_name: "きやん",
  family_name_kana: "てく",
  first_name_kana: "きやん", 
  date_of_birth: "19991231",
  ship_family_name: "手区",
  ship_first_name: "きやん",
  ship_family_name_kana: "てく",
  ship_first_name_kana: "きやん", 
  zip_code: "1234123",
  prefecture: "北海道",
  city: "札幌市",
  street: "南三条",
  room_number: "札幌コーポ111",
  tel: "01201234567"
)