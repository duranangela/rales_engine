require 'rails_helper'

describe 'Transactions API' do
  context 'GET /api/v1/transactions' do
    it 'gets a list of all transactions' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      create_list(:transaction, 3, invoice_id: invoice.id)

      get '/api/v1/transactions'

      expect(response).to be_successful

      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction = transactions.first

      expect(transactions.count).to eq(3)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:credit_card_expiration_date)
      expect(transaction).to have_key(:result)
    end
  end
  context 'GET /api/v1/transactions:id' do
    it 'can get one transaction by its id' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      id = create(:transaction, invoice_id: invoice.id).id

      get "/api/v1/transactions/#{id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction["id"]).to eq(id)
    end
  end
end
