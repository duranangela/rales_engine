class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_items(quantity)
    select('items.*, count(invoice_items.item_id) as total_items')
    .joins(invoices: [:invoice_items, :transactions]).where(transactions: {result: "success"})
    .group(:id)
    .order('total_items desc')
    .limit(quantity)
  end
end
