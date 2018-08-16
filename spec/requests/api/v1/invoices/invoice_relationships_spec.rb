require 'rails_helper'

describe 'Invoices Relationships' do
  context 'GET /api/v1/invoices/:id/transactions' do
    it 'gets the associated transactions for an invoice' do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      create_list(:transaction, 2, invoice_id: invoice.id)

      get "/api/v1/invoices/#{invoice.id}/transactions"

      expect(response).to be_successful

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(2)
    end
  end
  context 'GET /api/v1/invoices/:id/invoice_items' do
    it 'gets the associated invoice_items for an invoice' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      create_list(:invoice_item, 2, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoices/#{invoice.id}/invoice_items"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(2)
    end
  end
  context 'GET /api/v1/invoices/:id/items' do
    it 'gets the associated items for an invoice' do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      item1 = create(:item, merchant_id: merchant.id)
      item2 = create(:item, merchant_id: merchant.id)
      invoice_item1 = create(:invoice_item, invoice_id: invoice.id, item_id: item1.id)
      invoice_item2 = create(:invoice_item, invoice_id: invoice.id, item_id: item2.id)

      get "/api/v1/invoices/#{invoice.id}/items"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items.count).to eq(2)
    end
  end
end
