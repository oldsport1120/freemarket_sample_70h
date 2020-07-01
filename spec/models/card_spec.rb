require 'rails_helper'

# RSpec.describe Card, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

context "createアクションにアクセスした時" do
  before do
    payjp_customer = double("Payjp::Customer")
    payjp_card = double("Payjp::Card")
    allow(Payjp::Customer).to receive(:create).and_return(payjp_customer)        
    allow(payjp_customer).to receive(:cards).and_return(payjp_list)        
    allow(payjp_customer).to receive(:id).and_return('dummy_customer_id')
  end
  it "@cardが定義されていること" do
    post :create, params: {token: "dummy_payjp_token"}
    card = create(:card, user_id: user.id, customer_id: "dummy_customer_id")
    expect(assigns(:card).customer_id).to eq(card.customer_id)
  end
end

it '決済ができる' do
  customer_mock = double(:customer_mock) 
  charge_mock = double(:charge_mock)
  allow(Payjp::Customer).to receive(:create).and_return(customer_mock) 
  allow(Payjp::Customer).to receive(:retrieve).and_return(customer_mock)
  allow(Payjp::Charge).to receive(:create).and_return(charge_mock)
  allow(customer_mock).to receive(:id).and_return('dummy_customer_id') 
  allow(charge_mock).to receive(:id).and_return('dummy_charge_id')
  allow(charge_mock).to receive(:price).and_return(1000)

  
end