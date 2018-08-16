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
end
