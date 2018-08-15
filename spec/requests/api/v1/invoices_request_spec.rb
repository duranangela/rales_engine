require 'rails_helper'

describe "Invoices API" do
  context 'GET /api/v1/invoices' do
    it "sends a list of invoices" do
      customer1 = create(:customer)
      merchant1 = create(:merchant)
      create_list(:invoice, 3, customer_id: customer1.id, merchant_id: merchant1.id)

      get '/api/v1/invoices'

      expect(response).to be_successful
    end
  end

  context 'GET /api/v1/invoices/:id' do
    it 'can get one invoice by its id' do
      customer1 = create(:customer)
      merchant1 = create(:merchant)
      id = create(:invoice, merchant_id: merchant1.id, customer_id: customer1.id).id

      get "/api/v1/invoices/#{id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice["id"]).to eq(id)
    end
  end
end
