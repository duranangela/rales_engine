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

  def self.top_items(quantity)
    select("items.*, sum(invoice_items.quantity*invoice_items.unit_price) as revenue")
    .joins(invoices: :transactions)
    .where(transactions: {result: "success"})
    .group(:id)
    .order("revenue desc")
    .limit(quantity)
  end

  def best_day
    invoices.select("sum(invoice_items.quantity) as total_quantity, invoices.*")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: "success"})
    .group("date_trunc('day', invoice_items.created_at), invoices.id")
    .order("total_quantity desc")
    .limit(1)
    .first
    .created_at
  end
end
