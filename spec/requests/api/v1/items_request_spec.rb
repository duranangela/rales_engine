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
  context 'GET/api/v1/items/find?parameters' do
    it 'can find item by parameter id' do
      merchant = create(:merchant)
      item = create(:item, id: 1, merchant_id: merchant.id)
      item2 = create(:item, id: 2, merchant_id: merchant.id)

      get "/api/v1/items/find?id=2"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item["id"]).to eq(item2.id)
    end
  end
  context 'GET/api/v1/items/find_all?parameters' do
    it 'can find all items by merchant id' do
      merchant = create(:merchant, id: 1)
      item = create(:item, id: 1, merchant_id: merchant.id)
      item2 = create(:item, id: 2, merchant_id: merchant.id)

      get "/api/v1/items/find_all?merchant_id=1"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item.length).to eq(2)
    end
  end
end
