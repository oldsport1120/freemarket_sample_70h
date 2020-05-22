require 'rails_helper'

# 以下devise_usersに関するテスト nonaka
# example **** が空の場合登録できないことを確かめるテストコード 
describe User do
  describe '#create' do
    it "nicknameがない場合は登録できないこと" do
      user = User.new(nickname: "", email: "kkk@gmail.com", password: "00000000", password_confirmation: "00000000")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end
    it "emailがない場合は登録できないこと" do
      user = User.new(nickname: "Techcamp", email: "", password: "00000000", password_confirmation: "00000000")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    it "passwordがない場合は登録できないこと" do
      user = User.new(nickname: "Techcamp", email: "kkk@gmail.com", password: "", password_confirmation: "00000000")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
    it "passwordが存在してもpassword_confirmationがない場合は登録できないこと" do
      user = User.new(nickname: "Techcamp", email: "kkk@gmail.com", password: "00000000", password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
  end
end

# **** がない場合に登録できてしまうこと（テスト失敗狙い）
describe User do
  describe '#create' do
    it "nicknameがない場合に登録できてしまうこと（テスト失敗狙い）" do
      user = User.new(nickname: "", email: "kkk@gmail.com", password: "00000000", password_confirmation: "00000000")
      user.valid?
      expect(user.errors[:nickname]).to include("")
    end
    it "emailがない場合に登録できてしまうこと（テスト失敗狙い）" do
      user = User.new(nickname: "Techcamp", email: "", password: "00000000", password_confirmation: "00000000")
      user.valid?
      expect(user.errors[:nickname]).to include("")
    end
    it "passwordがない場合に登録できてしまうこと（テスト失敗狙い）" do
      user = User.new(nickname: "Techcamp", email: "kkk@gmail.com", password: "", password_confirmation: "00000000")
      user.valid?
      expect(user.errors[:nickname]).to include("")
    end
  end
end


describe User do
  describe '#create' do
    # password が指定文字数に足りない場合に登録できないこと（成功狙い）
    it "passwordが7文字以上ない場合は登録できないこと" do
      user = User.new(nickname: "Techcamp", email: "kkk@gmail.com", password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end
    # password が指定文字数に足る場合に登録できること（失敗狙い）
    it "passwordが7文字以上ならエラー文が出ないこと" do
      user = User.new(nickname: "Techcamp", email: "kkk@gmail.com", password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end
  end
end

describe User do
  describe '#create' do
    # 全ての入力事項を入力すれば登録できること（成功狙い）
    it "全ての入力事項を入力すれば登録できること" do
      user = User.new(nickname: "Techcamp", email: "kkk@gmail.com", password: "00000000", password_confirmation: "00000000", family_name: "田中", first_name: "一郎", family_name_kana: "たなか", first_name_kana: "いちろう", date_of_birth: "1941-06-15", ship_family_name: "田中", ship_first_name: "次郎", ship_family_name_kana: "たなか", ship_first_name_kana: "じろう", zip_code: "1234567", prefecture: "神奈川県", city: "第一市", street: "天神１丁目" )
      expect(user).to be_valid
    end
  end
end

# 以上devise_usersに関するテスト nonaka



