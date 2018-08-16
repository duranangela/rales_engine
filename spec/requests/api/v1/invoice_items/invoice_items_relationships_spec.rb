require 'rails_helper'

describe 'InvoiceItems Relationships' do
  context 'GET /api/v1/invoice_items/:id/invoice' do
    it 'gets the associated invoice for an invoice_item' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      id = create(:invoice, merchant_id: merchant.id, customer_id: customer.id).id
      invoice_item = create(:invoice_item, item_id: item.id, invoice_id: id)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice["id"]).to eq(id)
    end
  end
end
