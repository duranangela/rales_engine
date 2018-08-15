require 'rails_helper'

describe 'Merchants API' do
  context 'GET /api/vi/merchants' do
    it 'gets a list of all merchants' do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)
      merchant = merchants.first

      expect(merchants.count).to eq(3)
      expect(merchant).to have_key(:name)
    end
  end
  context 'GET /api/v1/merchants/:id' do
    it 'can get one merchant by its id' do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["id"]).to eq(id)
    end
  end

  context 'GET /api/v1/merchants/:id/favorite_customer' do
    it 'can get favorite customer by its id for a merchant' do
      merchant = create(:merchant)
      customer = create(:customer)
      customer_2 = create(:customer)
      invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      invoice3 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant.id)

      get "/api/v1/merchants/#{merchant.id}/favorite_customer"

      actual_response = JSON.parse(response.body)

      expect(response).to be_successful
      expect(actual_response['id']).to eq(customer.id)
      expect(actual_response['first_name']).to eq(customer.first_name)

    end
  end
end
