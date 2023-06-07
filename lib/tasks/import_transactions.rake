namespace :import do
  desc "Import transactions from a CSV file"
  task transactions: :environment do
    require 'csv'

    # Delete all existing transactions
    Transaction.delete_all

    CSV.foreach('transactions.csv', headers: true) do |row|
      puts "Processing row: #{row.inspect}"  # Output the entire row for debugging

      # Strip leading/trailing whitespace from all fields
      row = row.each_with_object({}) { |(k, v), h| h[k.strip] = v.strip if v }

      category = Category.find_or_create_by(name: row['Category'])
      merchant = Merchant.find_or_create_by(name: row['Merchant'])
      date = row['Date'].present? ? Date.strptime(row['Date'], "%m/%d/%Y") : nil

      puts "Amount (before conversion): #{row['Amount']}"  # Output the raw amount value
      amount = row['Amount'].to_d  # Convert to decimal
      puts "Amount (after conversion): #{amount}"  # Output the converted amount value

      Transaction.create(
        name: row['Transaction Name'],
        merchant: merchant,
        amount: amount,
        transaction_date: date,
        category: category
      )
    end
  end
end
