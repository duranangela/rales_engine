class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    if params[:date]
      date = Date.parse("#{params[:date]} 00:00:00 UTC")
      revenue_by_date = Merchant.find(params[:id]).total_revenue_by_date(date)
      render json: {"revenue" =>"#{(revenue_by_date/100).round(2)}"}
    else
      revenue = Merchant.find(params[:id]).total_revenue
      render json: {"revenue" =>"#{(revenue/100).round(2)}"}
    end
  end

end
