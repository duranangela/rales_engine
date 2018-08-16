class Api::V1::Merchants::TopMerchantsController < ApplicationController

  def show
    render json: Merchant.top_merchants(params[:quantity])
  end
end
