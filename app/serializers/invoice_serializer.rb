class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :status, :merchant_id, :customer_id

  # belongs_to :merchant
  # belongs_to :customer

end
