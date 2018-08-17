require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
  end
  describe 'relationships' do
    it {should have_many(:invoices)}
    it {should have_many(:merchants).through(:invoices)}
  end
  describe 'instance methods' do
    it 'can give favorite merchant for a customer' do
      customer = create(:customer)
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
      invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
      item = create(:item, merchant_id: merchant1.id)
      invoice_items1 = create_list(:invoice_item, 2, item_id: item.id, invoice_id: invoice1.id, unit_price: 4, quantity: 2)
      invoice_items2 = create_list(:invoice_item, 2, item_id: item.id, invoice_id: invoice2.id)
      transaction1 = create(:transaction, result: "success", invoice_id: invoice1.id)

      expect(customer.favorite_merchant).to eq(merchant1)
    end
  end
end
