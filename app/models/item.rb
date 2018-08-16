class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.top_items(quantity)
    select("items.*, sum(invoice_items.quantity*invoice_items.unit_price) as revenue")
    .joins(invoices: :transactions)
    .where(transactions: {result: "success"})
    .group(:id)
    .order("revenue desc")
    .limit(quantity)
  end
end
