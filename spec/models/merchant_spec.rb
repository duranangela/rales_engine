require 'rails_helper'

RSpec.describe Merchant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe 'validations' do
    it {should validate_presence_of(:name)}
  end
  describe 'relationships' do
    it {should have_many(:invoices)}
    it {should have_many(:items)}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'instance methods' do
    it 'finds favorite customer for a merchant' do
      merchant = create(:merchant)
      customer = create(:customer)
      customer2 = create(:customer)
      invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      invoice3 = create(:invoice, customer_id: customer2.id, merchant_id: merchant.id)

      expected_result = customer

      expect(merchant.favorite_customer_for_merchant).to eq(expected_result)
    end
  end
end
