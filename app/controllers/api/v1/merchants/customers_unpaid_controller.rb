class Api::V1::Merchants::CustomersUnpaidController < ApplicationController

  def show
    render json: Merchant.find(params[:id]).customers.pending_invoices(params[:id])
  end

end
