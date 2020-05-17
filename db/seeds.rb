# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 初期データ・テストデータ投入 nonaka
# こちらのデータはターミナルで$rails db:seed で流し込めます とりあえず３データ埋まります nonaka

3.times do |n|
  User.create!(
    nickname: "Tech#{n + 1}",
    email: "admin#{n + 1}@2222",
    password: "admin#{n + 1}12345",
    encrypted_password: "admin#{n + 1}12345",
    family_name: "手区#{n + 1}",
    first_name: "きやん#{n + 1}",
    family_name_kana: "てく#{n + 1}",
    first_name_kana: "きやん#{n + 1}", 
    date_of_birth: "1999-12-31",
    ship_family_name: "手区#{n + 1}",
    ship_first_name: "きやん#{n + 1}",
    ship_family_name_kana: "てく#{n + 1}",
    ship_first_name_kana: "きやん#{n + 1}", 
    zip_code: "123412#{n + 1}",
    prefecture: "北海道",
    city: "札幌市",
    street: "南三条",
    room_number: "札幌コーポ111",
    tel: "0120123456#{n + 1}"
  )
end
