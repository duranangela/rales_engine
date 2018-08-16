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
end
