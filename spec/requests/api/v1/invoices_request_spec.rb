require 'rails_helper'

describe "Invoices API" do
  xit "sends a list of invoices" do
    customer1 = create(:customer)
    merchant1 = create(:merchant)
    create_list(:invoice, 3, customer_id: customer1.id, merchant_id: merchant1.id)

    get '/api/v1/invoices'

    expect(response).to be_successful
  end
end
