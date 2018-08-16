require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do

    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful
    customers = JSON.parse(response.body)

    expect(customers.count).to eq(3)
  end
  it "can get one customer by its id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(id)
  end

  # relationships endpoint
  context 'GET /api/v1/customers/:id/invoices' do
    it 'returns a collection of associated invoices' do
      customer_1 = create(:customer)
      merchant_1 = create(:merchant)
      create_list(:invoice, 5, customer_id: customer_1.id, merchant_id: merchant_1.id)

      get "/api/v1/customers/#{customer_1.id}/invoices"

      expect(response).to be_successful

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(5)
    end
  end
end
