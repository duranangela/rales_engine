class Customer < ApplicationRecord

  validates_presence_of :first_name, :last_name

  has_many :invoices
  # has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.favorite_customer_for_merchant(merch_id)
    select("customers.*, count(transactions.id) as invoice_count").joins(:invoices, :transactions, :merchants).where(transactions: {result: "success"}).where(merchants: {id: merch_id}).group(:id).order("invoice_count desc").limit(1).first
  end
end
