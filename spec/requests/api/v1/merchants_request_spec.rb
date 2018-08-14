require 'rails_helper'

describe 'Merchants API' do
  context 'GET /api/vi/merchants' do
    it 'gets a list of all merchants' do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful
    end
  end
end
