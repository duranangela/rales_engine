require 'rails_helper'

describe 'Items Relationships API' do
  context 'GET /api/v1/items/:id/merchant' do
    it 'gets the associated merchant for an item' do
      id = create(:merchant).id
      item = create(:item, merchant_id: id)

      get "/api/v1/items/#{item.id}/merchant"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)

      expect(merchant["id"]).to eq(id)
    end
  end
end
