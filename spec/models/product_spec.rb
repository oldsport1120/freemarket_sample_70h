require 'rails_helper'

describe Product do
  describe '#create' do
    it "products_nameがない場合は登録できないこと" do
      product = Product.new(products_name: "", descreption: "aaa", price: "10000", product_condition: "目立った傷や汚れなし", shipment_fee: "送料込み(出品者負担)", shipping_place: "1", shipping_period: "1")
      product.valid?
      expect(product.errors[:products_name]).to include("を入力してください")
    end
    it "descreptionがない場合は登録できないこと" do
      product = Product.new(products_name: "aaa", descreption: "", price: "10000", product_condition: "目立った傷や汚れなし", shipment_fee: "送料込み(出品者負担)", shipping_place: "1", shipping_period: "1")
      product.valid?
      expect(product.errors[:descreption]).to include("を入力してください")
    end
    it "priceがない場合は登録できないこと" do
      product = Product.new(products_name: "aaa", descreption: "aaa", price: "", product_condition: "目立った傷や汚れなし", shipment_fee: "送料込み(出品者負担)", shipping_place: "1", shipping_period: "1")
      product.valid?
      expect(product.errors[:price]).to include("を入力してください")
    end
    it "product_conditionがない場合は登録できないこと" do
      product = Product.new(products_name: "aaa", descreption: "aaa", price: "10000", product_condition: "", shipment_fee: "送料込み(出品者負担)", shipping_place: "1", shipping_period: "1")
      product.valid?
      expect(product.errors[:product_condition]).to include("を入力してください")
    end
    it "shipment_feeがない場合は登録できないこと" do
      product = Product.new(products_name: "aaa", descreption: "aaa", price: "10000", product_condition: "目立った傷や汚れなし", shipment_fee: "", shipping_place: "1", shipping_period: "1")
      product.valid?
      expect(product.errors[:shipment_fee]).to include("を入力してください")
    end
    it "shipping_placeがない場合は登録できないこと" do
      product = Product.new(products_name: "aaa", descreption: "aaa", price: "10000", product_condition: "目立った傷や汚れなし", shipment_fee: "送料込み(出品者負担)", shipping_place: "", shipping_period: "1")
      product.valid?
      expect(product.errors[:shipping_place]).to include("を入力してください")
    end
    it "shipping_periodがない場合は登録できないこと" do
      product = Product.new(products_name: "aaa", descreption: "aaa", price: "10000", product_condition: "目立った傷や汚れなし", shipment_fee: "送料込み(出品者負担)", shipping_place: "1", shipping_period: "")
      product.valid?
      expect(product.errors[:shipping_period]).to include("を入力してください")
    end
  end
end

