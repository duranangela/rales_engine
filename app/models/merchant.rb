class Merchant < ApplicationRecord

  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def favorite_customer_for_merchant
    # require "pry"; binding.pry
    Customer.select('customers.*, count(invoices.id) AS invoice_customer').
            joins(:invoices, :merchants, :transactions).
            where(transactions: {result: 'success' })
            group("customers.id").
            order('invoice_customer DESC').limit(1).first
  end

  def total_revenue
    invoices.joins(:invoice_items, :transactions)
    .where(transactions: {result: "success"})
    .sum('quantity*unit_price')
  end
end
