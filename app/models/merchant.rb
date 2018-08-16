class Merchant < ApplicationRecord

  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def total_revenue
    invoices.joins(:invoice_items, :transactions)
    .where(transactions: {result: "success"})
    .sum('quantity*unit_price')
  end

  def total_revenue_by_date(date)
    invoices.joins(:invoice_items, :transactions)
    .where(transactions: {result: "success"})
    .where("invoices.updated_at BETWEEN '#{date}' AND '#{date + 1}'")
    .sum('quantity*unit_price')
  end

  def self.revenue_merchants_on_a_date(date)
     joins(invoices: [:invoice_items, :transactions])
     .where(invoices: {updated_at: date.beginning_of_day..date.end_of_day})
     .where(transactions: {result: "success"})
     .sum('quantity*unit_price')
  end

  def self.top_merchants(quantity)
    select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price)as revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"})
    .group(:id)
    .order("revenue desc").limit(quantity)
  end
end
