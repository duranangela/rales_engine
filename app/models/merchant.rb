class Merchant < ApplicationRecord

  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def favorite_customer_for_merchant
    Customer.select('customers.*, count(invoices.customer_id) AS invoice_customer').
            joins(:invoices).
            group("customers.id").
            order('invoice_customer DESC').limit(1).first.id
  end
end
