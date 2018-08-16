require 'rails_helper'

describe "Items API" do
  context 'GET /api/v1/items' do
    it "sends a list of items" do
      merchant = create(:merchant)
      create_list(:item, 5, merchant_id: merchant.id)

      get '/api/v1/items'

      expect(response).to be_successful
    end
  end
end
