class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  scope :success, -> {where(status: 'shipped')}

  def self.most_expensive(limit = 5)
  end

  def self.revenue_merchants_on_a_date(date)
    date_format = Date.parse(date)

    select("sum(invoice_items.quantity*invoice_items.unit_price) as revenue").joins(:invoice_items, :transactions).where(transactions: {result: "success"}).where(invoices: {created_at: date_format.beginning_of_day..date_format.end_of_day}).group("date_trunc('day', invoices.created_at)").order("revenue desc").limit(1)
  end

end
