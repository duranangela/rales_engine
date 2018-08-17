class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: Item.where('unit_price=?', (params[:unit_price].to_d*100).to_i) if params[:unit_price]
    render json: Item.where('id=?', params[:id]) if params[:id]
    render json: Item.where('name=?', params[:name]) if params[:name]
    render json: Item.where('description=?', params[:description]) if params[:description]
    render json: Item.where('merchant_id=?', params[:merchant_id]) if params[:merchant_id]
    render json: Item.where('created_at=?', params[:created_at]) if params[:created_at]
    render json: Item.where('updated_at=?', params[:updated_at]) if params[:updated_at]
  end

  def show
    render json: Item.order(:id).find_by(search_params)
  end

  private

  # def search_params
  #   a = params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
    def search_params
    params[:unit_price] = params[:unit_price].delete('.').to_i if params[:unit_price]
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  # end

  end
  # def show
  #   render json: Item.find_by('id=?', params[:id]) if params[:id]
  #   render json: Item.find_by('name=?', params[:name]) if params[:name]
  #   render json: Item.find_by('description=?', params[:description]) if params[:description]
  #   render json: Item.find_by('unit_price=?', (params[:unit_price].to_d*100).to_i) if params[:unit_price]
  #   render json: Item.find_by('merchant_id=?', params[:merchant_id]) if params[:merchant_id]
  #   render json: Item.order(:id).find_by('created_at=?', params[:created_at]).order(:id) if params[:created_at]
  #   render json: Item.find_by('updated_at=?', params[:updated_at]) if params[:updated_at]
  # end

end
