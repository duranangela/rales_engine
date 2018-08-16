class Api::V1::Merchants::RevenueMerchantsDateController < ApplicationController

  def show
    date = Date.parse("#{params[:date]} 00:00:00 UTC")
    revenue = Merchant.revenue_merchants_on_a_date(date)
    render json: {"total_revenue" =>"#{(revenue/100).round(2)}"}
  end

end
