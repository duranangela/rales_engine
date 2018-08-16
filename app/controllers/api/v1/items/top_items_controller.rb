class Api::V1::Items::TopItemsController < ApplicationController

  def show
    render json: Item.top_items(params[:quantity])
  end
end
