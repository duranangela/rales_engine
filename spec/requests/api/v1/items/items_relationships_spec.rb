require 'rails_helper'

describe 'Items Relationships API' do
  context 'GET /api/v1/items/:id/merchant' do
    it 'gets the associated merchant for an item' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/#{item.id}/merchant"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)

      expect(merchant["id"]).to eq(merchant.id)
    end
  end
end
