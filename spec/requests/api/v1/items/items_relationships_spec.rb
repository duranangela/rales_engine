require 'rails_helper'

describe 'Items Relationships API' do
  context 'GET /api/v1/items/:id/merchant' do
    it 'gets the associated merchant for an item' do
      id = create(:merchant).id
      item = create(:item, merchant_id: id)

      get "/api/v1/items/#{item.id}/merchant"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)

      expect(merchant["id"]).to eq(id)
    end
  end
  context 'GET /api/v1/items/:id/invoice_items' do
    it 'gets the associated invoice_items for an item' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      create_list(:invoice_item, 4, item_id: item.id, invoice_id: invoice.id)

      get "/api/v1/items/#{item.id}/invoice_items"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(4)
    end
  end
end
