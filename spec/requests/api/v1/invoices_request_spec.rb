require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    customer = Customer.create()
    create(:merchant)
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_successful
  end
end
