class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def show
    render json: Customer.favorite_customer_for_merchant(params[:id])
  end

end
