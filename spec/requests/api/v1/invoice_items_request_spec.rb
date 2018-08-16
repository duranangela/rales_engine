require 'rails_helper'

describe "Invoice Items API" do
  context 'GET /api/v1/invoice_items' do
    it "sends a list of invoice items" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      create_list(:invoice_item, 5, item_id: item.id, invoice_id: invoice.id)

      get '/api/v1/invoice_items'

      expect(response).to be_successful
    end
  end
end
