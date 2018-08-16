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
  context 'GET /api/v1/transactions/find?parameters' do
    it 'can find one transaction by parameters' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      transaction = create(:transaction, invoice_id: invoice.id)

      get "/api/v1/transactions/find?id=#{transaction.id}"

      expect(response).to be_successful

      trans = JSON.parse(response.body)
      expect(trans["id"]).to eq(transaction.id)

      get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"
      trans = JSON.parse(response.body)
      expect(trans["invoice_id"]).to eq(transaction.invoice_id)

      get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"
      trans = JSON.parse(response.body)
      expect(trans["credit_card_number"]).to eq(transaction.credit_card_number)

      get "/api/v1/transactions/find?result=#{transaction.result}"
      trans = JSON.parse(response.body)
      expect(trans["result"]).to eq(transaction.result)
    end
  end
  context 'GET /api/v1/transactions/find_all?parameters' do
    it 'can find all transaction by parameters' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      transaction1 = create(:transaction, invoice_id: invoice.id)
      transaction2 = create(:transaction, invoice_id: invoice.id)

      get "/api/v1/transactions/find_all?id=#{transaction1.id}"

      expect(response).to be_successful

      trans = JSON.parse(response.body)
      expect(trans.count).to eq(1)

      get "/api/v1/transactions/find_all?invoice_id=#{transaction1.invoice_id}"
      trans = JSON.parse(response.body)
      expect(trans.count).to eq(2)

      get "/api/v1/transactions/find_all?credit_card_number=#{transaction1.credit_card_number}"
      trans = JSON.parse(response.body)
      expect(trans.count).to eq(2)

      get "/api/v1/transactions/find_all?result=#{transaction1.result}"
      trans = JSON.parse(response.body)
      expect(trans.count).to eq(2)
    end
  end
  context 'GET/api/v1/transactions/random.json' do
    it 'can find a random transaction' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      create_list(:transaction, 4, invoice_id: invoice.id)

      get "/api/v1/transactions/random"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction.count).to eq(1)
    end
  end
end
