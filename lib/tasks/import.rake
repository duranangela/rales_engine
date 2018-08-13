require 'csv'

namespace :import do
  desc "Import merchants from CSV file"

  task merchant: :environment do
    CSV.foreach('db/csv/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_h)
    end
  end
end

#   desc "TODO"
#   task customer: :environment do
#   end
#
#   desc "TODO"
#   task invoice: :environment do
#   end
#
#   desc "TODO"
#   task invoice_item: :environment do
#   end
#
#   desc "TODO"
#   task item: :environment do
#   end
#
#   desc "TODO"
#   task transaction: :environment do
#   end
#
# end
