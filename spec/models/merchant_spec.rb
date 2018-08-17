require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
  end
  describe 'relationships' do
    it {should have_many(:invoices)}
    it {should have_many(:items)}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'instance methods' do
    # xit 'finds favorite customer for a merchant' do
    #   merchant = create(:merchant, id:1)
    #   customer = create(:customer)
    #   customer2 = create(:customer)
    #   invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    #   invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    #   invoice3 = create(:invoice, customer_id: customer2.id, merchant_id: merchant.id)
    #
    #   expected_result = customer
    #
    #   expect(Customer.favorite_customer_for_merchant(merchant.id)).to eq(expected_result)
    # end
    it 'gives total revenue for a merchant' do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      item = create(:item, merchant_id: merchant.id)
      invoice_items1 = create_list(:invoice_item, 2, item_id: item.id, invoice_id: invoice1.id, unit_price: 4, quantity: 2)
      invoice_items2 = create_list(:invoice_item, 2, item_id: item.id, invoice_id: invoice2.id)
      transaction1 = create(:transaction, result: "success", invoice_id: invoice1.id)
      transaction2 = create(:transaction, result: "failed", invoice_id: invoice2.id)

      expect(merchant.total_revenue).to eq(16)
    end
  end
end
