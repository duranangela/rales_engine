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

  context 'GET /api/v1/invoice_items/:id' do
    it "can get one invoice item by its id" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item_id = create(:invoice_item, item_id: item.id, invoice_id: invoice.id).id

      get "/api/v1/invoice_items/#{invoice_item_id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item["id"]).to eq(invoice_item_id)
    end
  end
  context 'GET /api/v1/invoice_items/find?parameters' do
    it "can find invoice item by id" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item_1 = create(:invoice_item, id: 1, item_id: item.id, invoice_id: invoice.id)
      invoice_item_2 = create(:invoice_item, id: 2, item_id: item.id, invoice_id: invoice.id)

      get "/api/v1/invoice_items/find?id=2"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item["id"]).to eq(invoice_item_2.id)
    end
  end
end
