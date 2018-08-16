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

  context 'GET /api/v1/items/:id' do
    it "can get one item by its id" do
      merchant = create(:merchant)
      item_id = create(:item, merchant_id: merchant.id).id

      get "/api/v1/items/#{item_id}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item["id"]).to eq(item_id)
    end
  end
end
