class Transaction < ApplicationRecord
    belongs_to :merchant
    belongs_to :category
  
    def self.import_from_csv(file_path)
      CSV.foreach(file_path, headers: true) do |row|
        transaction_data = row.to_hash
        category_name = transaction_data.delete('category')
        merchant_name = transaction_data.delete('merchant')
  
        category = Category.find_or_create_by(name: category_name)
        merchant = Merchant.find_or_create_by(name: merchant_name)
  
        transaction = Transaction.new(transaction_data)
        transaction.category = category
        transaction.merchant = merchant
        transaction.save
      end
    end
  
    def mark_as_reviewed
      update(reviewed: true)
    end
  
    def update_category(new_category)
      category = Category.find_or_create_by(name: new_category)
      update(category: category)
    end
  end
  