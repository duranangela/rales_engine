class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    revenue = Merchant.find(params[:id]).total_revenue
    render json: {"revenue" =>"#{(revenue/100).round(2)}"}
  end

end
