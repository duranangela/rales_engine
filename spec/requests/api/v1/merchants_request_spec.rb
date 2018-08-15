require 'rails_helper'

describe 'Merchants API' do
  it 'gets a list of all merchants' do
    create_list(:merchant, 3)
    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    merchant = merchants.first

    expect(merchants.count).to eq(3)
    expect(merchant).to have_key(:name)
  end
  it 'can get one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end
  it 'can search by the id' do
    id = create(:merchant).id

    get "/api/v1/merchants/find?id=#{id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["id"]).to eq(id)
  end
  it 'can search by name' do
    name = create_list(:merchant, 3).first.name

    get "/api/v1/merchants/find?name=#{name}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["name"]).to eq(name)
  end
end
