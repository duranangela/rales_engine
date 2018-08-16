class Api::V1::Merchants::RevenueMerchantsDateController < ApplicationController

  def show
    render json: Invoice.revenue_merchants_on_a_date(date)
  end

end
