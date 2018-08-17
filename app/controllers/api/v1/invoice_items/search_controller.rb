class Api::V1::InvoiceItems::SearchController < ApplicationController

  def show
    render json: InvoiceItem.find_by('unit_price=?', (params[:unit_price].to_d*100).to_i) if params[:unit_price]
    render json: InvoiceItem.find_by('id=?', params[:id]) if params[:id]
    render json: InvoiceItem.find_by('item_id=?', params[:item_id]) if params[:item_id]
    render json: InvoiceItem.find_by('invoice_id=?', params[:invoice_id]) if params[:invoice_id]
    render json: InvoiceItem.find_by('quantity=?', params[:quantity]) if params[:quantity]
    render json: InvoiceItem.find_by('created_at=?', params[:created_at]) if params[:created_at]
    render json: InvoiceItem.find_by('updated_at=?', params[:updated_at]) if params[:updated_at]
  end

  def index
    render json: InvoiceItem.where('unit_price=?', (params[:unit_price].to_d*100).to_i) if params[:unit_price]
    render json: InvoiceItem.where('id=?', params[:id]) if params[:id]
    render json: InvoiceItem.where('item_id=?', params[:item_id]) if params[:item_id]
    render json: InvoiceItem.where('invoice_id=?', params[:invoice_id]) if params[:invoice_id]
    render json: InvoiceItem.where('quantity=?', params[:quantity]) if params[:quantity]
    render json: InvoiceItem.where('created_at=?', params[:created_at]) if params[:created_at]
    render json: InvoiceItem.where('updated_at=?', params[:updated_at]) if params[:updated_at]
  end
end
