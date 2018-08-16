class InvoiceItemSerializer < ActiveModel::Serializer

  attributes :id, :invoice_id, :item_id, :quantity, :unit_price

  def unit_price
    (object.unit_price * 0.01.round(2)).to_s
  end

end
